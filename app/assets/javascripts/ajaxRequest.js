// Vamos a implementar las funciones de recuperacion de datos para la navegacion general obviamente cuando trabajemos con rails, deberemos hacer unos de AjaxRails(remote => true) pero la esencia de los callbacks es la misma

//Al hacer una peticion por ajax como esta a la funcion ubicada en el servidor en la direccion login.php
$(document).ready(function() {
  $('#login').submit(function() {
    var formData = $(this).serialize();
    $.post('login.php',formData,processData);
    return false;
  });
});

/*La respuesta del servidor puede ser o bien un XML como este*/
/*
<books>
  <book>
    <title>JavaScript, the Definitive Guide</title>
    <publisher>O'Reilly</publisher>
    <author>David Flanagan</author>
    <cover src="/images/cover_defguide.jpg" />
    <blurb>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</blurb>
  </book>
  <book>
    <title>DOM Scripting</title>
    <publisher>Friends of Ed</publisher>
    <author>Jeremy Keith</author>
    <cover src="/images/cover_domscripting.jpg" />
    <blurb>Praesent et diam a ligula facilisis venenatis.</blurb>
  </book>
  <book>
    <title>DHTML Utopia: Modern Web Design using JavaScript &amp; DOM</title>
    <publisher>Sitepoint</publisher>
    <author>Stuart Langridge</author>
    <cover src="/images/cover_utopia.jpg" />
    <blurb>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</blurb>
  </book>
</books>
*/

// y lo procesaremos asi:
function processData(req)
{
  var books = req.responseXML.getElementsByTagName('book');
  for (var i=0;i<books.length;i++)
  {
    var x = document.createElement('div');
    x.className = 'book';
    var y = document.createElement('h3');
    y.appendChild(document.createTextNode(getNodeValue(books[i],'title')));
    x.appendChild(y);
    var z = document.createElement('p');
    z.className = 'moreInfo';
    z.appendChild(document.createTextNode('By ' + getNodeValue(books[i],'author') + ', ' + getNodeValue(books[i],'publisher')));
    x.appendChild(z);
    var a = document.createElement('img');
    a.src = books[i].getElementsByTagName('cover')[0].getAttribute('src');
    x.appendChild(a);
    var b = document.createElement('p');
    b.appendChild(document.createTextNode(getNodeValue(books[i],'blurb')));
    x.appendChild(b);
    document.getElementById('writeroot').appendChild(x);
  }
}


// o puede responder con un JSON (LO MAS PROBABLE QUE HAGAMOS) asi:
/*
{"books":[{"book":
    {
    "title":"JavaScript, the Definitive Guide",
    "publisher":"O'Reilly",
    "author":"David Flanagan",
    "cover":"/images/cover_defguide.jpg",
    "blurb":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    }
  },
  {"book":
    {
    "title":"DOM Scripting",
    "publisher":"Friends of Ed",
    "author":"Jeremy Keith",
    "cover":"/images/cover_domscripting.jpg",
    "blurb":"Praesent et diam a ligula facilisis venenatis."
    }
  },
  {"book":
    {
    "title":"DHTML Utopia: Modern Web Design using JavaScript & DOM",
    "publisher":"Sitepoint",
    "author":"Stuart Langridge",
    "cover":"/images/cover_utopia.jpg",
    "blurb":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    }
  }
]}
*/

// y lo procesaremos asi:
function processData(req)
{
  var data = eval('(' + req.responseText + ')');
  for (var i=0;i<data.books.length;i++)
  {
    var x = document.createElement('div');
    x.className = 'book';
    var y = document.createElement('h3');
    y.appendChild(document.createTextNode(data.books[i].book.title));
    x.appendChild(y);
    var z = document.createElement('p');
    z.className = 'moreInfo';
    z.appendChild(document.createTextNode('By ' + data.books[i].book.author + ', ' + data.books[i].book.publisher));
    x.appendChild(z);
    var a = document.createElement('img');
    a.src = data.books[i].book.cover;
    x.appendChild(a);
    var b = document.createElement('p');
    b.appendChild(document.createTextNode(data.books[i].book.blurb));
    x.appendChild(b);
    document.getElementById('writeroot').appendChild(x);
  }
}


// Es un ejemplo con libros, pero en nuestro caso seran ofertas, o negociaciones o productos... depende de lo que pida el usuarios