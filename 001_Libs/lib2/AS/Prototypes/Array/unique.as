Array.prototype.unique=function(){ // destructive
	var z,y;
	for (y=0; y<this.length; y++){
		z=this.length-1;
		while(y<z){
			if(this[y]==this[z]) this.splice(z,1);
			z--;
		}
	}
	return this;
}
Array.prototype.unique2=function(){ // non destructive (destructive on copy) & slowest
	var z,y,a=this.slice();
	for (y=0; y<a.length; y++){
		z=a.length-1;
		while(y<z){
			if(a[y]==a[z]) a.splice(z,1);
			z--;
		}
	}
	return a;
}
Array.prototype.unique3=function(){ // non destructive & fastest
	var z,y=this.length,c=false,a=[];
	while (y--){
		z=0;
		while(z<y){
			if(this[y]==this[z]){
				c=true;
				break;
			}
			z++;
		}
		if (!c) a[a.length]=this[y];
		else c=false;
	}
	return a;
}
Array.prototype.unique4=function(){ // non destructive & fastest, simple data types only
	var y=this.length,a=[],o={};
	o.__proto__ = null;
	while (y--){
		if (o[this[y]] == undefined) a[a.length] = o[this[y]] = this[y];
	}
	return a;
}