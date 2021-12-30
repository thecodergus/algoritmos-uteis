const frutas = [{
	nome : 'Banana'
},
{
	nome : 'Maça'
},
{
	nome : 'Pera'
},
{
	nome : 'Amora'
}];
 
frutas.sort(function (a, b) {
	
	return (a.nome > b.nome) ? 1 : ((b.nome > a.nome) ? -1 : 0);
 
});