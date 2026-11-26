package com.example.psicometric;

import android.os.Handler;
import android.os.Looper;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** Cliente minimo para hablar con el backend en Azure (sin librerias extra). */
public class ApiClient {

    /** Servidor en Azure. Si activas HTTPS con certificado, cambia http:// por https://. */
    public static final String BASE_URL =
            "https://alejandro-martinez.northcentralus.cloudapp.azure.com";

    public interface Callback {
        void onSuccess(JSONObject data);
        void onError(String mensaje);
    }

    private static final ExecutorService IO = Executors.newSingleThreadExecutor();
    private static final Handler MAIN = new Handler(Looper.getMainLooper());

    public static void login(String rol, String correo, String contrasena, Callback cb) {
        IO.execute(() -> {
            HttpURLConnection con = null;
            try {
                JSONObject body = new JSONObject();
                body.put("rol", rol);
                body.put("correo", correo);
                body.put("contrasena", contrasena);

                con = (HttpURLConnection) new URL(BASE_URL + "/api/auth/login").openConnection();
                con.setRequestMethod("POST");
                con.setConnectTimeout(10000);
                con.setReadTimeout(15000);
                con.setDoOutput(true);
                con.setRequestProperty("Content-Type", "application/json; charset=utf-8");
                con.setRequestProperty("Accept", "application/json");

                try (OutputStream os = con.getOutputStream()) {
                    os.write(body.toString().getBytes(StandardCharsets.UTF_8));
                }

                int code = con.getResponseCode();
                InputStream is = code >= 400 ? con.getErrorStream() : con.getInputStream();
                String texto = leer(is);

                if (code == 200) {
                    JSONObject json = new JSONObject(texto);
                    MAIN.post(() -> cb.onSuccess(json));
                } else if (code == 401) {
                    MAIN.post(() -> cb.onError("Correo o contraseña incorrectos"));
                } else {
                    MAIN.post(() -> cb.onError("Error del servidor (" + code + ")"));
                }
            } catch (java.net.UnknownHostException | java.net.SocketTimeoutException
                     | java.net.ConnectException e) {
                MAIN.post(() -> cb.onError("No se pudo conectar con el servidor"));
            } catch (Exception e) {
                MAIN.post(() -> cb.onError("Error: " + e.getMessage()));
            } finally {
                if (con != null) con.disconnect();
            }
        });
    }

    private static String leer(InputStream is) throws Exception {
        if (is == null) return "";
        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String linea;
            while ((linea = br.readLine()) != null) sb.append(linea);
        }
        return sb.toString();
    }
}
