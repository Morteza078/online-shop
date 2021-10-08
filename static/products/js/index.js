if (languege_code==='fa'){
  var rial='ریال'
}
else {
    var rial='Rial'
}
$(document).ready(function () {
    $.ajax({
        url: 'http://127.0.0.1:8000/en/api/products/',
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            var next_page = response['next']
            var previous_page = response['previous']
            var products = response['results']
            if ((response['count'] % 8) === 0) {
                var page_n = response['count'] / 8;
            } else {
                var page_n = Math.floor(response['count'] / 8) + 1;
            }
            var product_block = ""
            for (let i = 1; i <= products.length; i++) {
                let product_name=''
                let product_description=''
              if(languege_code==='fa'){
                       product_name=products[i-1]['name_fa']
                      product_description=products[i-1]['description_fa']
                }
              else{
                   product_name=products[i-1]['name_en']
                    product_description=products[i-1]['description_en']
              }
                let product_price=products[i-1]['price']
                 let product_id=products[i-1]['id']
                let image1=products[i-1]['images'][0]['image']
                product_block += ` <div class="col mb-5">
                    <div class="card h-100">
                   <div id="${product_name}" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-inner">
                                <!-- Product images--> 
                                    <div class="carousel-item active p-5">
                                        <img src="${image1}" class="d-block w-100" alt="...">
                                    </div>`
                for (let j = 2; j <= products[i-1]['images'].length; j++){
                 let image= products[i-1]['images'][j-1]['image']
                    // product_block+= "<div class='carousel-item'>"+'<img src=${image} class="d-block w-100" alt="...">'+"</div>"
                   product_block+=` <div class="carousel-item p-5">
                                            <img src="${image}" class="d-block w-100" alt="...">
                                        </div>`
                }


                product_block += `   
                                </div>
                                <button class="carousel-control-prev" type="button"
                                        data-bs-target="#${product_name}"
                                        data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button"
                                        data-bs-target="#${product_name}"
                                        data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>` + `<div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder">${product_name}</h5>
                                <!-- Product reviews-->
                                <div class="d-flex justify-content-center small text-warning mb-2">
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                </div>
                                <!-- Product price-->
                                ${product_price}${rial}<br>
                                  
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                           <a href="product_detail/${product_id}"  class="stretched-link"></a>
                        </div>
                    </div>
                </div>`


            }
           $("#block_image").html(product_block)

            var move_buttons = ` <li class="page-item">
                                       <button type="button" id="previous" value="${previous_page}"  class="page-link"  onclick="move_page_next_previous(this)" href="" aria-label="Previous">
                                          <span aria-hidden="true">&laquo;</span>
                                            <span class="sr-only">Previous</span>
                                                  </button>
                                            </li>`

            for (let i = 0; i < page_n; i++) {
                move_buttons += `<li class="page-item"><button value="${i+1}" class="page-link" onclick="move_page_number(this)" href="#">${i+1}</button></li>`
            }

            move_buttons += ` <li class="page-item">
                         <button type="button" id="next" value="${next_page}" onclick="move_page_next_previous(this)" class="page-link" href="" aria-label="Next">
                              <span  aria-hidden="true">&raquo;</span>
                                 <span class="sr-only">Next</span>
                                
                             </button>
                             </li>`
            $(".pagination").html(move_buttons)


        }
    })


})

function move_page_next_previous(button) {
    if (button.value === 'null') {
    } else {
         $.ajax({
        url: button.value,
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            var next_page = response['next']
            var previous_page = response['previous']
            var products = response['results']
            if ((response['count'] % 8) === 0) {
                var page_n = response['count'] / 8;
            } else {
                var page_n = Math.floor(response['count'] / 8) + 1;
            }
            var product_block = ""
            for (let i = 1; i <= products.length; i++) {
                let product_name=''
                let product_description=''
              if(languege_code==='fa'){
                       product_name=products[i-1]['name_fa']
                      product_description=products[i-1]['description_fa']
                }
              else{
                   product_name=products[i-1]['name_en']
                    product_description=products[i-1]['description_en']
              }

                let product_price=products[i-1]['price']
                let product_id=products[i-1]['id']
                let image1=products[i-1]['images'][0]['image']
                product_block += ` <div class="col mb-5">
                    <div class="card h-100">
                   <div id="${product_name}" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-inner">
                                <!-- Product images--> 
                                    <div class="carousel-item active p-5">
                                        <img src="${image1}" class="d-block w-100" alt="...">
                                    </div>`
                for (let j = 2; j <= products[i-1]['images'].length; j++){
                 let image= products[i-1]['images'][j-1]['image']
                    // product_block+= "<div class='carousel-item'>"+'<img src=${image} class="d-block w-100" alt="...">'+"</div>"
                   product_block+=` <div class="carousel-item p-5">
                                            <img src="${image}" class="d-block w-100" alt="...">
                                        </div>`
                }


                product_block += `   
                                </div>
                                <button class="carousel-control-prev" type="button"
                                        data-bs-target="#${product_name}"
                                        data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button"
                                        data-bs-target="#${product_name}"
                                        data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>` + `<div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder">${product_name}</h5>
                                <!-- Product reviews-->
                                <div class="d-flex justify-content-center small text-warning mb-2">
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                </div>
                                <!-- Product price-->
                                ${product_price}${rial}<br>
                                    
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                             <a href="product_detail/${product_id}"  class="stretched-link"></a>
                        </div>
                    </div>
                </div>`


            }
           $("#block_image").html(product_block)

            var move_buttons = ` <li class="page-item">
                                       <button type="button" id="previous" value="${previous_page}"  class="page-link"  onclick="move_page_next_previous(this)" href="" aria-label="Previous">
                                          <span aria-hidden="true">&laquo;</span>
                                            <span class="sr-only">Previous</span>
                                                  </button>
                                            </li>`

            for (let i = 0; i < page_n; i++) {

                move_buttons += `<li class="page-item"><button value="${i+1}" class="page-link" onclick="move_page_number(this)" href="#">${i+1}</button></li>`
            }

            move_buttons += ` <li class="page-item">
                         <button type="button" id="next" value="${next_page}" onclick="move_page_next_previous(this)" class="page-link" href="" aria-label="Next">
                              <span  aria-hidden="true">&raquo;</span>
                                 <span class="sr-only">Next</span>
                                
                             </button>
                             </li>`
            $(".pagination").html(move_buttons)


        }
    })


    }

}

function move_page_number(button) {
     $.ajax({
        url: 'http://127.0.0.1:8000/en/api/products/?page='+button.value,
        contentType: "application/json",
        dataType: 'json',
        success: function (response) {
            var next_page = response['next']
            var previous_page = response['previous']
            var products = response['results']
            if ((response['count'] % 8) === 0) {
                var page_n = response['count'] / 8;
            } else {
                var page_n = Math.floor(response['count'] / 8) + 1;
            }
            var product_block = ""
            for (let i = 1; i <= products.length; i++) {
               let product_name=''
                let product_description=''
              if(languege_code==='fa'){
                       product_name=products[i-1]['name_fa']
                      product_description=products[i-1]['description_fa']
                }
              else{
                   product_name=products[i-1]['name_en']
                    product_description=products[i-1]['description_en']
              }
                let product_price=products[i-1]['price']
                    let product_id=products[i-1]['id']
                let image1=products[i-1]['images'][0]['image']
                product_block += ` <div class="col mb-5">
                    <div class="card h-100">
                   <div id="${product_name}" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-inner">
                                <!-- Product images--> 
                                    <div class="carousel-item active p-5">
                                        <img src="${image1}" class="d-block w-100" alt="...">
                                    </div>`
                for (let j = 2; j <= products[i-1]['images'].length; j++){
                 let image= products[i-1]['images'][j-1]['image']
                    // product_block+= "<div class='carousel-item'>"+'<img src=${image} class="d-block w-100" alt="...">'+"</div>"
                   product_block+=` <div class="carousel-item p-5">
                                            <img src="${image}" class="d-block w-100" alt="...">
                                        </div>`
                }


                product_block += `   
                                </div>
                                <button class="carousel-control-prev" type="button"
                                        data-bs-target="#${product_name}"
                                        data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button"
                                        data-bs-target="#${product_name}"
                                        data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>` + `<div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder">${product_name}</h5>
                                <!-- Product reviews-->
                                <div class="d-flex justify-content-center small text-warning mb-2">
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                </div>
                                <!-- Product price-->
                                ${product_price}${rial}<br>
                                  
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                         <a href="product_detail/${product_id}"  class="stretched-link"></a>
                        </div>
                    </div>
                </div>`


            }
           $("#block_image").html(product_block)

            var move_buttons = ` <li class="page-item">
                                       <button type="button" id="previous" value="${previous_page}"  class="page-link"  onclick="move_page_next_previous(this)" href="" aria-label="Previous">
                                          <span aria-hidden="true">&laquo;</span>
                                            <span class="sr-only">Previous</span>
                                                  </button>
                                            </li>`

            for (let i = 0; i < page_n; i++) {

                move_buttons += `<li class="page-item"><button value="${i+1}" class="page-link" onclick="move_page_number(this)" href="#">${i+1}</button></li>`
            }

            move_buttons += ` <li class="page-item">
                         <button type="button" id="next" value="${next_page}" onclick="move_page_next_previous(this)" class="page-link" href="" aria-label="Next">
                              <span  aria-hidden="true">&raquo;</span>
                                 <span class="sr-only">Next</span>
                                
                             </button>
                             </li>`
            $(".pagination").html(move_buttons)


        }
    })
}

