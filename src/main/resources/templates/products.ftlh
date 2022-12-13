<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Поиск товаров</h1><hr>
    <form method="get" action="/">
        <div class="form-row">
            <div class="form-group col-md-2">
                <label for="searchCity">Город</label>
                <select id="searchCity" name="searchCity" class="form-control">
                    <option value="">Город не выбран</option>
                    <option id="Москва" name="searchCity" value="Москва">Москва</option>
                    <option id="Красноярск" name="searchCity" value="Красноярск">Красноярск</option>
                    <option id="Казань" name="searchCity" value="Казань">>Казань</option>
                </select>
            </div>
            <div class="form-group col-md-10">
                <label for="searchWord">Поиск по объявлениям</label>
                <input type="text" name="searchWord" <#if searchWord??>value="${searchWord}"</#if> class="form-control"
                       id="searchWord">
            </div>
            <button style="width: 100%" type="submit" class="btn btn-dark">Поиск</button>
        </div>
    </form>
    <hr>
    <div class="card-columns">
       <#list products as product>
            <a href="/product/${product.id}" class="product-link">
                <div class="card text-white bg-dark my-3 product">
                    <div class="card-top">
<#--                        <form action="/cart/add/${product.id}" method="post">-->
<#--                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>-->
<#--                            <button type="submit" class="btn btn-primary m-3">-->
<#--                                Добавить в корзину-->
<#--                            </button>-->
<#--                        </form>-->

                        <#if user.isBuyer()>
                            <form action="/cart/add/${product.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-primary m-3">
                                    Добавить в корзину
                                </button>
                            </form>
                        </#if>
                    </div>
                    <img src="/images/${product.previewImageId}"
                         class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">${product.title}</h5>
                        <p class="card-text">${product.price} ₽</p>
                    </div>
                    <div class="card-footer">
                        ${product.city}
                    </div>
                </div>
            </a>
        <#else>
            <h1 style="text-align: center">Не найдено</h1>
        </#list>
    </div>
</@t.template>