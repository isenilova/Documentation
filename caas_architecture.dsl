workspace {

    model {
    # user agents
        user = person "User" "CaaS software system user"
        
        
        # external systems
        ton = softwareSystem "TON Blockchain" "TON"
        
        tonstorage = softwareSystem "TON Storage" "IPFS"
        cdns = softwareSystem "Content Delivery Networks"
        
        # caas software components
        caas = softwareSystem "CaaS Software" "Community-as-a-Service software system" {
            group "Frontend" {
                
               
                webApp = container "CaaS application" "Uses for SMM campaigns automatization" "Fastify & Tailwind CSS + AWS hosting & TWA" "WebApp"
            }
            group "Cloud Layer" {
             
              caasApp = container "CaaS API" "Allows authenticated interaction with CaaS Cloud services" "Fastify & tRPC + Docker & Kubernetes cluster" "API"
            }
            group "Storage Layer" {
               
                storage = container "Long-term Storage" "Stores NFT & SBT source files" "IPFS & TON Storage" "Storage"
                database = container "Distrubuted Database" "Stores user private data" "Offline graph database GunDB" "Database"
                onchainstorage = container "On-chain Storage" "Stores community data & user profiles" "Sharded FunC contracts" "On-chain Storage"
            }
            
            group "Backend Layer" {
                contracts = container "CaaS smart contracts" "Provides business logic & source of trust" "FunC" "Contracts"
                indexer = container "Indexing & Monitoring Service" "Indexes & Analyses on-chain data" "Orbs TON Access RPC network & GraphQL" "Indexer"
                
            }
            
            
        }
        
        #inter container relationships
        webApp -> caasApp "Uses API" "HTTPS"
        #webApp #-> mobileApp "Uses API" "HTTPS"
        #cdn #-> <mobileApp|hn> "hghg"
        
        #mobileApp #-> cdns "Mobile Stores" "App Store & Google Play"
        webApp -> database "Reads from & writes to" "WebRTC"
        webApp -> storage "Writes to & reads from" "IPFS & HTPS"
        caasApp -> storage "Writes to & reads from" "IPFS & HTPS"
        webApp -> onchainstorage "Writes to & reads from" "tonweb-js-sdk & TON Connect 2.0"
        caasApp -> onchainstorage "Writes to & reads from" "tonweb-js-sdk"
        
        #mobileApp #-> storage "Reads from" "HTTPS"
        caasApp -> contracts "Interacts on-chain" "tonweb-js-sdk"        
        storage -> tonstorage "Writes to" "TON Storage Gateway"
        indexer -> webApp "Retrieves data to" "GraphQL IDE"
        
        # container-context relationships
        indexer -> ton "Read from" "HTTPS"
       
       
       
        
        contracts -> ton "Executed on" "Evernode Platform"
        
        onchainstorage -> ton "Executed on" "Evernode Platform"
        user -> webApp "Interacts with" "Telergam & TWA"
       
        user -> caasApp "Uses API" "HTTPS"
       
        
        # context level relationships
        user -> caas "Uses to participate in community activities"
      
        caas -> ton "Uses as public ledger"
        caas -> tonstorage "Uses as distributed storage" "TON Storage Gateway"
        #dao #-> vself "Does dev ops and decision making"
         development = deploymentEnvironment "vSelf Software" {
            deploymentNode "App Store & Google Play" {
                containerInstance webApp
                deploymentNode "Stores" {
                    #containerInstance stores
                }
            }
            
            deploymentNode "Docker & Kubernetes Cluster" {
                containerInstance caasApp
                deploymentNode "Cloud" {
                    #containerInstance stores
                }
            }
            
            deploymentNode "AWS Hosting" {
                containerInstance webApp
                deploymentNode "Hosting" {
                    #containerInstance stores
                }
            }
        }
        
       
    }

    views {
        systemContext caas "SystemContext" {
            include *
            autoLayout
        }
        
        deployment * "vSelf Software" {
            include *
            #autoLayout lr
            }
        
        container caas {
            include *
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            
            element "Database" {
                shape cylinder
            }
            
            
            
            element "WebApp" {
                shape WebBrowser
            }
            
            

            element "Storage" {
                shape Folder
            }
            element "On-chain Storage" {
                shape Folder
            }

            element "Indexer" {
                shape RoundedBox
            }
        }
    }
    
}