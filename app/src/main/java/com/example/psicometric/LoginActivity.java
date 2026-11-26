package com.example.psicometric;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.RadioGroup;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONObject;

public class LoginActivity extends AppCompatActivity {

    private RadioGroup grupoRol;
    private EditText etCorreo, etContra;
    private Button btnEntrar;
    private ProgressBar progreso;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        grupoRol = findViewById(R.id.grupoRol);
        etCorreo = findViewById(R.id.etCorreo);
        etContra = findViewById(R.id.etContra);
        btnEntrar = findViewById(R.id.btnEntrar);
        progreso = findViewById(R.id.progreso);

        btnEntrar.setOnClickListener(v -> intentarLogin());
    }

    private String rolSeleccionado() {
        int id = grupoRol.getCheckedRadioButtonId();
        if (id == R.id.rolTutor) return "TUTOR";
        if (id == R.id.rolPsicologo) return "PSICOLOGO";
        return "PACIENTE";
    }

    private void intentarLogin() {
        String correo = etCorreo.getText().toString().trim();
        String contra = etContra.getText().toString();
        if (correo.isEmpty() || contra.isEmpty()) {
            Toast.makeText(this, "Escribe tu correo y contraseña", Toast.LENGTH_SHORT).show();
            return;
        }
        cargando(true);
        ApiClient.login(rolSeleccionado(), correo, contra, new ApiClient.Callback() {
            @Override
            public void onSuccess(JSONObject d) {
                cargando(false);
                new SessionManager(LoginActivity.this).guardar(
                        d.optString("rol"), d.optInt("id", -1),
                        d.optString("nombre"), d.optString("correo"));
                Intent i = new Intent(LoginActivity.this, MainActivity.class);
                i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
                startActivity(i);
                finish();
            }

            @Override
            public void onError(String mensaje) {
                cargando(false);
                Toast.makeText(LoginActivity.this, mensaje, Toast.LENGTH_LONG).show();
            }
        });
    }

    private void cargando(boolean si) {
        progreso.setVisibility(si ? View.VISIBLE : View.GONE);
        btnEntrar.setEnabled(!si);
    }
}
