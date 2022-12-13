<#--<#import "blocks/template.ftlh" as t>-->
<#--<@t.template user>-->
<#--    <!DOCTYPE html>-->
<#--    <html lang="en" xmlns:th="http://www.thymeleaf.org">-->
<#--    <head>-->
<#--        <meta charset="UTF-8">-->
<#--        <title>Корзина товаров</title>-->
<#--    </head>-->
<#--    <body>-->
<#--    <form method="get" th:action="@{/index}">-->
<#--        <input type="submit" value="Личный кабинет">-->
<#--    </form>-->
<#--    <h3>Корзина товаров</h3>-->
<#--    <div th:each="product : ${cart_product}">-->
<#--        <img th:src="'/img/' + ${product.imageList[0].getFileName()}" width="100px">-->
<#--        <br>-->
<#--        <a th:href="@{/product/info/{id}(id=${product.getId()})}" th:text="${product.getTitle()}"></a>-->
<#--        <p th:text="'Цена: ' + ${product.getPrice()}"></p>-->
<#--        <a th:href="@{/cart/delete/{id}(id=${product.getId()})}">Удалить</a>-->
<#--        <hr>-->
<#--    </div>-->
<#--    <h3 th:text="'Итоговая цена: ' + ${price}"></h3>-->
<#--    <a href="/order/create">Оформить заказ</a>-->
<#--    </body>-->
<#--    </html>-->

<#--</@t.template>-->
<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Поиск товаров</h1><hr>
    <form method="get" action="/">
        <div class="form-row">
            <div class="form-group col-md-2">
                <label for="searchCity">Город</label>
                <select id="searchCity" class="form-control">
                    <option value="">Город не выбран</option>
                    <option value="Москва">Москва</option>
                    <option value="Красноярск">Красноярск</option>
                    <option value="Казань">Казань</option>
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