library(shiny)
library(httr)

shinyServer(function(input, output, session) {

    observe({
        if( session$clientData$url_search != "")
        {
            if(is.null(session$user))
            {
                query <- parseQueryString(session$clientData$url_search)
                if(!is.null(query$code))
                {
                    pc_json <- paste0(
                        'grant_type=authorization_code', '&',
                        'client_id={client_id}', '&',
                        'client_secret={client_secret}', '&',
                        'redirect_uri=', GetRedirectUrl(session), '&',
                        'code=', query$code)
                    
                    req <- httr::POST(url = "https://kauth.kakao.com/oauth/token",body = pc_json)
                    session$user$token <- content(req)
                    #@print(result)
                    #result$access_token
                    #session$user <- result$access_token
                    
                    req <- httr::POST(
                        url = "https://kapi.kakao.com/v2/user/me",
                        add_headers(
                            'Authorization' = paste0('Bearer ', session$user$token$access_token),
                            'Content-type' = 'application/x-www-form-urlencoded;charset=utf-8'
                        )
                    )
                    session$user$data <- content(req)
                    
                    inserted <- c()
                    
                    btn <- input$insertBtn
                    id <- paste0('txt', btn)
                    insertUI(
                        selector = '#placeholder',
                        ui = tags$div(
                            #tags$src(src = session$user$data$properties$thumbnail_image),
                            tags$p(session$user$data$kakao_account$profile$nickname),
                            id = id
                        )
                    )
                    inserted <<- c(id, inserted)
                }
            }
        }
        
        #print(session$clientData$url_search)
        #parseQueryString("?foo=1&bar=b%20a%20r")
    })
    
    observeEvent(input$login, {
        session$sendCustomMessage("redirect", GetKakaoRedirectUrl(session))
    })
    
    output$queryText <- renderText({
        
        paste0(
            "hash: ", session$user$data$properties$thumbnail_image, "\n",
            "hash: ", session$user$data$kakao_account$profile$nickname, "\n",
            "hash: ", session$clientData$url_hash, "\n",
            "hash_initial: ", session$clientData$url_hash_initial, "\n",
            "protocol: ", session$clientData$url_protocol, "\n",
            "pathname: ", session$clientData$url_pathname, "\n",
            "hostname: ", session$clientData$url_hostname, "\n",
            "port: ",     session$clientData$url_port,     "\n",
            "search: ",   session$clientData$url_search,   "\n"
        )
    })
    
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    
    observeEvent(input$roadviewshow, {
        session$sendCustomMessage("roadviewshow", '')
    })
    
    observeEvent(input$roadviewhide, {
        session$sendCustomMessage("roadviewhide", '')
    })
    
    observeEvent(input$markershow, {
        session$sendCustomMessage("markershow", '')
    })
    
    observeEvent(input$penTo, {
        message <- list(
            lat = 33.450580,
            long = 126.574942
        )
        session$sendCustomMessage("panto", message = message)
    })
    
    output$text <- renderText({
        req(input$count)
        paste("마커를 ", input$count, "번 클릭 하였습니다.")
    })

})

GetKakaoRedirectUrl <- function(session) {
    
    GetKakaoRedirectUrl <- paste0(
        "https://kauth.kakao.com/oauth/authorize?",
        "response_type=code&",
        "client_id=",
        "86fcdbd47e764b260ff9fd54dd223258",
        "&",
        "redirect_uri=",
        GetRedirectUrl(session)
    )
}

GetRedirectUrl <- function(session, pathname) {
    clientData <- session$clientData
    
    pathname <- ""
    if( is.null(pathname) )
    {
        pathname <- clientData$url_pathname
    }
    
    GetRedirectUrl <- paste0(
        clientData$url_protocol,
        '//',
        clientData$url_hostname,
        ':',
        clientData$url_port,
        pathname
    )
}
