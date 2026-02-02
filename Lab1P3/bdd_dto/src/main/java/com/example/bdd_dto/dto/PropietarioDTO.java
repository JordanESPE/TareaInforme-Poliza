package com.example.bdd_dto.dto;

import java.util.List;

public class PropietarioDTO {
    private Long id;
    private String nombre;
    private String apellido;
    private int edad;
    private List<Long> automovilIds;
    private List<String> modelos; // Lista de nombres de modelos

    public PropietarioDTO() {
        // Constructor vacío necesario para frameworks como Jackson
    }

    public PropietarioDTO(Long id, String nombre, String apellido, int edad, List<Long> automovilIds) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
        this.automovilIds = automovilIds;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public List<Long> getAutomovilIds() {
        return automovilIds;
    }

    public void setAutomovilIds(List<Long> automovilIds) {
        this.automovilIds = automovilIds;
    }

    public List<String> getModelos() {
        return modelos;
    }

    public void setModelos(List<String> modelos) {
        this.modelos = modelos;
    }

}
