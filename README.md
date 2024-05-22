# VehicleDynamics-Assignment2

Homework made by:
s319634 Matteo Gravagnone,
s318083 Danilo Guglielmi

## Domande da porre

1 - Come modellare la torsional stiffness degli half shafts -> anche per tip-in e tip-off test



2 - Motor torque generation time constant

-> Pure time delay - blocco Simulink time delay

-> Motor torque time constant -> modellare il motore con una funzione di trasferimento del primo ordine con costante di tempo pari alla constant



3 - Come deriviamo la potenza che può essere rigenerata a partire dalle ruote? (P = T*omega da quali ruote? Quelle motrici) [https://www.engineeringtoolbox.com/work-torque-d_1377.html]

-> 0.15-0.2 g di decelerazione si può frenare con la sola frenata rigenerativa

-> Per decelerazioni superiori, attenzione alla distribuzione della forza frenante tra front e rear (o solo frenata dissipativa o combinazione freni di servizio e rigener.)


4 - Power losses nei test di accelerazione: in termini di energia o andamento nel tempo della potenza?

-> Va bene mostrare l'energia dissipata durante i test, volendo si può provare a mettere su uno stesso grafico l'andamento della potenza



5 - Effective radius come va considerato? Problema forma 0/0 slip

-> Formula si applica per pure rolling conditions (-> utilizzare come radius il valore ottenuto precedentemente dall'effective roll radius o direttamente 0.97*wheel_radius )
