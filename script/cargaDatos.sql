

INSERT INTO difficulties (id, description) VALUES (1, 'F�cil');
INSERT INTO difficulties (id, description) VALUES (2, 'Media');
INSERT INTO difficulties (id, description) VALUES (3, 'Dif�cil');

INSERT INTO importances (id, description) VALUES (1, 'Prescindible');
INSERT INTO importances (id, description) VALUES (2, 'Imprescindible');

insert into units(id, unit, description) VALUES (1, '(unidades)', '');
insert into units(id, unit, description) VALUES (2,  'mililitros', 'ml de');
insert into units(id, unit, description) VALUES (3,  'gramos', 'gramos de');
insert into units(id, unit, description) VALUES (4,  'pizca', 'pizca de');
insert into units(id, unit, description) VALUES (5,  'cucharada', 'cucharada de');
insert into units(id, unit, description) VALUES (6,  'cucharada peque�a', 'cucharada peque�a de');
insert into units(id, unit, description) VALUES (7,  'hojas', 'hojas de');
insert into units(id, unit, description) VALUES (8,  'litros', 'litros de');
insert into units(id, unit, description) VALUES (9,  'diente', 'diente de');
insert into units(id, unit, description) VALUES (10,  'lonchas', 'lonchas de');

-- Recetas
insert into recipes(id, title, user_id, difficulty_id, time, servings, description, rating) VALUES (1, 'Patatas fritas', 1, 1, 30, 2, 'Como freir patatillas', 4);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (1, 97,  3,  1, 4);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (1, 336,  2,  2, 0.5);
insert into steps(recipe_id,  orden, time, description) VALUES (1, 1, 10, 'Pelar las patatas');
insert into steps(recipe_id,  orden, time, description) VALUES (1, 2, 5, 'Calentar el aceite');
insert into steps(recipe_id,  orden, time, description) VALUES (1, 3, 20, 'Fre�r las patatas');

insert into recipes(id, title, user_id, difficulty_id, time, servings, description, rating) VALUES (2, 'Jam�n con mel�n', 1, 1, 5, 4, '', 3);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (2, 324,  3,  3, 300);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (2, 5,  3,  1, 1);
insert into steps(recipe_id,  orden, time, description) VALUES (2, 1, 10, 'Cortar el mel�n en trozos, quit�ndole la piel');
insert into steps(recipe_id,  orden, time, description) VALUES (2, 2, 5, 'Coloque en palillos un trozo de mel�n y otro de jam�n serrano y servir');

insert into recipes(id, title, user_id, difficulty_id, time, servings, description, rating) VALUES (3, 'Pollo al ajillo', 1, 2, 35, 2, '', 2);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (3, 291,  3,  3, 500);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (3, 66,  3,  8, 3);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (3, 336,  1,  2, 50);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (3, 143,  2,  4, 1);
insert into steps(recipe_id,  orden, time, description) VALUES (3, 1, 10, 'Limpiar el pollo y los ajos');
insert into steps(recipe_id,  orden, time, description) VALUES (3, 2, 5, 'Mezclar el aceite, perejil y los ajos picados en un recipiente y cubrir el pollo con esta salsa.');
insert into steps(recipe_id,  orden, time, description) VALUES (3, 3, 1, 'Calienta una sarten con un chorro de aceite.');
insert into steps(recipe_id,  orden, time, description) VALUES (3, 4, 15, 'Fr�e el pollo con la salsa hasta que que �ste coja color.');

insert into recipes(id, title, user_id, difficulty_id, time, servings, description, rating) VALUES (4, 'Pan tumaca', 1, 1, 30, 4, '', 5);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 338,  3,  1, 1);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 95,  3,  3, 300);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 66,  2,  8, 3);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 336,  2,  2, 40);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 141,  1,  4, 1);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 141,  1,  4, 1);
insert into links(recipe_id, ingredient_id, importance_id, unit_id, number) VALUES (4, 328,  1,  4, 1);
insert into steps(recipe_id,  orden, time, description) VALUES (4, 1, 25, 'Calienta una sart�n con aceite de oliva y sofr�e los ajos. Cuando est�n empezando a hacerse incorpora los tomates triturados (retira antes la piel) y sigue cocinando a fuego lento.');
insert into steps(recipe_id,  orden, time, description) VALUES (4, 2, 2, 'Tueste el pan y a��dale un chorro de aceite de oliva virgen y una pizca de or�gano.');
insert into steps(recipe_id,  orden, time, description) VALUES (4, 3, 2, 'Cuando se termine de hacer la salsa de tomate a��dala a la tosta y cubra con una(s) lonchas de jam�n serrano.');




