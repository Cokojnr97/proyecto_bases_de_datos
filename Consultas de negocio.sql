SELECT * FROM Usuario;

SELECT 
nombre
FROM Usuario
WHERE estadoUsuario_id = (SELECT estadoUsuario_id FROM EstadoUsuario WHERE valor = 'ACTIVE');

SELECT
nombre
FROM Usuario
WHERE rolUsuario_id = (SELECT rolUsuario_id FROM RolUsuario WHERE valor = 'ADMIN');

SELECT * FROM Recurso;

SELECT
titulo, url 
FROM Recurso
WHERE estadoRecurso_id = (SELECT estadoRecurso_id FROM EstadoRecurso WHERE valor = 'PUBLICADO');

SELECT
r.titulo AS Recurso, u.nombre AS Creador
FROM Recurso r
INNER JOIN Usuario u ON r.creadoPor_usuario_id = u.usuario_id
WHERE r.estadoRecurso_id = (SELECT estadoRecurso_id FROM EstadoRecurso WHERE valor = 'BORRADOR');

SELECT
r.titulo AS Recurso, u.nombre AS Creador
FROM Recurso r
INNER JOIN Usuario u ON r.creadoPor_usuario_id = u.usuario_id
WHERE r.estadoRecurso_id = (SELECT estadoRecurso_id FROM EstadoRecurso WHERE valor = 'PUBLICADO');

SELECT nombre AS Nivel
FROM CursoClase;

SELECT * FROM CursoClaseRecurso;

SELECT
c.nombre AS CursoClase, r.titulo AS Recurso
FROM CursoClaseRecurso ccr
INNER JOIN CursoClase c ON ccr.cursoClase_id = c.cursoClase_id
INNER JOIN Recurso r ON ccr.recurso_id = r.recurso_id
ORDER BY c.orden, r.createdAt;

SELECT
u.nombre AS AdministradorSenior, COUNT(r.aprobadoPor_usuario_id) AS SolicitudesAprobadas
FROM Usuario u
INNER JOIN Recurso r ON u.usuario_id = r.aprobadoPor_usuario_id
WHERE u.rolUsuario_id = (SELECT rolUsuario_id FROM RolUsuario WHERE valor = 'ADMIN')
GROUP BY u.nombre
HAVING COUNT(r.aprobadoPor_usuario_id) > 5
ORDER BY SolicitudesAprobadas DESC;

SELECT
u.nombre AS AdministradorJunior, COUNT(r.aprobadoPor_usuario_id) AS SolicitudesAprobadas
FROM Usuario u
INNER JOIN Recurso r ON u.usuario_id = r.aprobadoPor_usuario_id
WHERE u.rolUsuario_id = (SELECT rolUsuario_id FROM RolUsuario WHERE valor = 'ADMIN')
GROUP BY u.nombre
HAVING COUNT(r.aprobadoPor_usuario_id) <= 5
ORDER BY SolicitudesAprobadas DESC;