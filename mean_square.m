% Programme approchant les mesures a l'aide de la methode du grandient
% M-file trancant la fonction integrale complementaire de Gauss a l'aide de
% approximation (cf. vol. XVII, p.518)

% Initialisation
delay    = 150; % Delay initial pour les decalages
inc_delay= 10;  % Incrementation du delay initial
par      = 50;  % Par. initial ds la fct de Gauss
inc_par  = 1;   % Incr. du par. de la fct de Gauss

% Initialisation des erreurs
err21   = 1e4;
err10   = 1e4;
err11   = 1e4;
err12   = 1e4;
err01   = 1e4;

err_rel_del = 1;
err_rel_par = 1;
err_rel_glob= 1;
err_rel_tol = 1e-12; % Diff. de 2 err. cons. (erreur relative)
Err= [];  

[taille tmp]= max(size(y_17));
% Boucle de calcul
while (err_rel_glob>err_rel_tol) & (par~=20)

 e11= sum((y_17'- Gauss(taille, par, round(delay))).^2);
 e12= sum((y_17'- Gauss(taille, par, round(delay+inc_delay))).^2);
 e21= sum((y_17'- Gauss(taille, par+inc_par, round(delay))).^2);
 e10= sum((y_17'- Gauss(taille, par, round(delay-inc_delay))).^2);
 e01= sum((y_17'- Gauss(taille, par-inc_par, round(delay))).^2);

 %e21
 %[e10 e11 e12]
 %e01
 Err= [Err e11];
 
 % Controle selon l'axe du delay
 if (e10<e11<e12)
  delay= delay- inc_delay;
 end
 if (e10==e11<e12)
delay= delay- inc_delay;
 end
 if (e10<e11==e12)
delay= delay- inc_delay;
 end

 if (e10>e11>e12)
  delay= delay+ inc_delay;
 end 
 if (e10==e11>e12)
  delay= delay+ inc_delay;
 end 
if (e10>e11==e12)
  delay= delay+ inc_delay;
 end 

 if (e10>e11<e12)    % Cas de la "cuvette"
  [tmp1 tmp2]= max([e10 e12]);
  err_rel_del= (tmp1-e11)/e11;
  inc_delay= inc_delay/2;
 end

 % Controle selon l'axe du par. de Gauss
 if (e01<e11<e21)
  par= par- inc_par;
 end 
if (e01==e11<e21)
  par= par- inc_par;
 end 
if (e01<e11==e21)
  par= par- inc_par;
 end 

 if (e01>e11>e21)
   par= par+ inc_par;
 end
if (e01==e11>e21)
   par= par+ inc_par;
 end
if (e01>e11==e21)
   par= par+ inc_par;
 end
 
 if (e01>e11<e21)     % Cas de la "cuvette"
   [tmp1 tmp2]= max([e01 e21]);
   err_rel_par= (tmp1-e11)/e11; 
   inc_par= inc_par/2;
 end

[delay par]
err_rel_glob= max([err_rel_del err_rel_par]) 
end

plot(y_17, 'r')
hold on
plot(Gauss(taille, par, round(delay)))
figure
plot(Err)
[min(Err) max(Err)]
[delay par]


