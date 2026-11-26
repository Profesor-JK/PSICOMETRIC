package com.example.psicometric;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import com.google.android.material.appbar.MaterialToolbar;
import com.google.android.material.navigation.NavigationView;

public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    private DrawerLayout drawerLayout;
    private ActionBarDrawerToggle toggle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        MaterialToolbar toolbar = findViewById(R.id.topAppBar);
        setSupportActionBar(toolbar);

        drawerLayout = findViewById(R.id.drawerLayout);
        NavigationView navigationView = findViewById(R.id.navigationView);
        DrawerLayout drawerLayout = findViewById(R.id.drawerLayout);

        navigationView.setNavigationItemSelectedListener(item -> {
            int id = item.getItemId();

            if (id == R.id.nav_home) {
                // Cargar tu fragmento de Inicio
                loadFragment(new HomeFragment());

            } else if (id == R.id.nav_test_search) {
                // Cargar fragmento de Búsqueda de tests
                loadFragment(new TestSearchFragment());

            } else if (id == R.id.nav_test_selection) {
                // Cargar fragmento de Elección de test
                loadFragment(new TestSelectionFragment());

            } else if (id == R.id.nav_test_administration) {
                // Cargar fragmento de Aplicación de test
                loadFragment(new TestAdministrationFragment());

            } else if (id == R.id.nav_visualization_of_results) {
                // Cargar fragmento de Visualización de resultados
                loadFragment(new ResultsFragment());

            } else if (id == R.id.nav_log_Out) {
                // Lógica de Cerrar Sesión
                cerrarSesion();

            } else if (id == R.id.nav_settings) {
                // Cargar fragmento de Configuración
                // loadFragment(new SettingsFragment());
            }

            // Cierra el menú lateral automáticamente al seleccionar una opción
            drawerLayout.closeDrawers();
            return true;
        });

        toggle = new ActionBarDrawerToggle(
                this,
                drawerLayout,
                toolbar,
                R.string.open,
                R.string.close
        );
        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();

        if (savedInstanceState == null) {
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.fragmentContainer, new HomeFragment())
                    .commit();
        }
    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.nav_home) {
        } else if (id == R.id.nav_test_search) {
        } else if (id == R.id.nav_test_selection) {
        } else if (id == R.id.nav_test_administration) {
        } else if (id == R.id.nav_visualization_of_results) {
        } else if (id == R.id.nav_log_Out) {
        } else if (id == R.id.nav_settings) {
        }

        drawerLayout.closeDrawer(GravityCompat.START);
        return true;
    }

    @Override
    public void onBackPressed() {
        if (drawerLayout.isDrawerOpen(GravityCompat.START)) {
            drawerLayout.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    private void loadFragment(androidx.fragment.app.Fragment fragment) {
        getSupportFragmentManager()
                .beginTransaction()
                .replace(R.id.fragmentContainer, fragment) // Asegúrate de que 'fragmentContainer' sea el ID en tu activity_main.xml
                .commit();
    }
    private void cerrarSesion() {
        // Si tienes datos guardados en SharedPreferences (como tokens o estado de sesión),
        // este es el momento de limpiarlos:
        // SharedPreferences preferences = getSharedPreferences("UserPrefs", MODE_PRIVATE);
        // preferences.edit().clear().apply();

        new SessionManager(this).cerrar();

        Intent intent = new Intent(MainActivity.this, LoginActivity.class);

        // Estas banderas limpian la pila de actividades para que MainActivity se destruya por completo
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);

        startActivity(intent);
        finish();
    }
}