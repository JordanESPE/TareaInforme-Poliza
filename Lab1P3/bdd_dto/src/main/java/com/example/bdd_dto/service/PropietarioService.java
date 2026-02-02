package com.example.bdd_dto.service;

import com.example.bdd_dto.dto.PropietarioDTO;
import com.example.bdd_dto.model.Propietario;
import com.example.bdd_dto.repository.PropietarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PropietarioService {
    private final PropietarioRepository propietarioRepository;

    public PropietarioService(PropietarioRepository propietarioRepository) {
        this.propietarioRepository = propietarioRepository;
    }

    public PropietarioDTO crear(PropietarioDTO propietarioDTO) {
        if (propietarioDTO.getEdad() < 18) {
            throw new RuntimeException("El propietario debe ser mayor de edad");
        }

        Propietario propietario = new Propietario();
        propietario.setNombre(propietarioDTO.getNombre());
        propietario.setApellido(propietarioDTO.getApellido());
        propietario.setEdad(propietarioDTO.getEdad());

        Propietario guardado = propietarioRepository.save(propietario);
        return convertirADTO(guardado);
    }

    public List<PropietarioDTO> obtenerTodos() {
        return propietarioRepository.findAll().stream()
                .map(this::convertirADTO)
                .collect(Collectors.toList());
    }

    public PropietarioDTO obtenerPorId(Long id) {
        Propietario propietario = propietarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propietario no encontrado"));
        return convertirADTO(propietario);
    }

    public PropietarioDTO actualizar(Long id, PropietarioDTO propietarioDTO) {
        Propietario propietario = propietarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propietario no encontrado"));

        propietario.setNombre(propietarioDTO.getNombre());
        propietario.setApellido(propietarioDTO.getApellido());
        propietario.setEdad(propietarioDTO.getEdad());

        Propietario actualizado = propietarioRepository.save(propietario);
        return convertirADTO(actualizado);
    }

    public void eliminar(Long id) {
        if (!propietarioRepository.existsById(id)) {
            throw new RuntimeException("Propietario no encontrado");
        }
        propietarioRepository.deleteById(id);
    }

    private PropietarioDTO convertirADTO(Propietario propietario) {
        PropietarioDTO dto = new PropietarioDTO();
        dto.setId(propietario.getId());
        dto.setNombre(propietario.getNombre());
        dto.setApellido(propietario.getApellido());
        dto.setEdad(propietario.getEdad());

        if (propietario.getAutomoviles() != null) {
            dto.setAutomovilIds(propietario.getAutomoviles().stream()
                    .map(a -> a.getId())
                    .collect(Collectors.toList()));

            dto.setModelos(propietario.getAutomoviles().stream()
                    .map(a -> a.getModelo())
                    .collect(Collectors.toList()));
        }

        return dto;
    }

    // Modificado para búsquedas parciales (insensitive case)
    public PropietarioDTO buscarPorNombre(String nombreBusqueda) {
        // Buscamos por coincidencia parcial en nombre O apellido
        Propietario propietario = propietarioRepository
                .findFirstByNombreContainingIgnoreCaseOrApellidoContainingIgnoreCase(nombreBusqueda, nombreBusqueda)
                .orElseThrow(() -> new RuntimeException("Propietario no encontrado con: " + nombreBusqueda));

        return convertirADTO(propietario);
    }

}