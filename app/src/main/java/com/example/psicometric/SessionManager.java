package com.example.psicometric;

import android.content.Context;
import android.content.SharedPreferences;

/** Guarda quien inicio sesion (rol, id, nombre, correo). */
public class SessionManager {
    private static final String PREFS = "UserPrefs";
    private final SharedPreferences prefs;

    public SessionManager(Context ctx) {
        prefs = ctx.getApplicationContext().getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    public void guardar(String rol, int id, String nombre, String correo) {
        prefs.edit().putBoolean("logueado", true).putString("rol", rol).putInt("id", id)
                .putString("nombre", nombre).putString("correo", correo).apply();
    }

    public boolean haySesion() { return prefs.getBoolean("logueado", false); }
    public String getRol()     { return prefs.getString("rol", ""); }
    public int getId()         { return prefs.getInt("id", -1); }
    public String getNombre()  { return prefs.getString("nombre", ""); }
    public String getCorreo()  { return prefs.getString("correo", ""); }
    public void cerrar()       { prefs.edit().clear().apply(); }
}
