package com.example.psicometric;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import androidx.appcompat.app.AppCompatActivity;

public class SplashActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash); // Carga tu diseño personalizado

        // Ocultar la barra de acción si aparece
        if (getSupportActionBar() != null) {
            getSupportActionBar().hide();
        }

        // Esperar 2.5 segundos y abrir MainActivity
        new Handler(Looper.getMainLooper()).postDelayed(() -> {
            Class<?> destino = new SessionManager(this).haySesion()
                    ? MainActivity.class : LoginActivity.class;
            Intent intent = new Intent(SplashActivity.this, destino);
            startActivity(intent);
            finish(); // Cierra el Splash para que no se pueda regresar a él
        }, 2500);
    }
}