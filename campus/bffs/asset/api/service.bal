import ballerina/http;
import ballerina/graphql;
import ballerina/log;

public function initClientConfig() returns ConnectionConfig{
    ConnectionConfig _clientConig = {};
    if (GLOBAL_DATA_USE_AUTH) {
        _clientConig.oauth2ClientCredentialsGrantConfig =  {
            tokenUrl: CHOREO_TOKEN_URL,
            clientId:GLOBAL_DATA_CLIENT_ID,
            clientSecret:GLOBAL_DATA_CLIENT_SECRET
        };
    } else { 
        _clientConig = {};
    }
    return _clientConig;
}


final GraphqlClient globalDataClient = check new (GLOBAL_DATA_API_URL,
    config = initClientConfig()
);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service / on new http:Listener(9094) {

    resource function get asset (int assetId) returns Asset|error {
        GetAssetResponse|graphql:ClientError getAssetResponse = globalDataClient->getAsset(assetId);
        if(getAssetResponse is GetAssetResponse) {
            Asset|error asset = getAssetResponse.asset.cloneWithType(Asset);
            if(asset is Asset) {
                return asset;
            } else {
                log:printError("Error while processing Application record received", asset);
                return error("Error while processing Application record received: " + asset.message() + 
                    ":: Detail: " + asset.detail().toString());
            }
        } else {
            log:printError("Error while getting application", getAssetResponse);
            return error("Error while getting application: " + getAssetResponse.message() + 
                ":: Detail: " + getAssetResponse.detail().toString());
        }
    }

    resource function get assets () returns Asset[]|error {
        GetAssetsResponse|graphql:ClientError getAssetsResponse = globalDataClient->getAssets();
        if(getAssetsResponse is GetAssetsResponse) {
            Asset[] assets = [];
            foreach var asset in getAssetsResponse.assets {
                Asset|error asset_record = asset.cloneWithType(Asset);
                if(asset_record is Asset) {
                    assets.push(asset_record);
                } else {
                    log:printError("Error while processing Application record received", asset_record);
                    return error("Error while processing Application record received: " + asset_record.message() + 
                        ":: Detail: " + asset_record.detail().toString());
                }
            }

            return assets;
            
        } else {
            log:printError("Error while getting application", getAssetsResponse);
            return error("Error while getting application: " + getAssetsResponse.message() + 
                ":: Detail: " + getAssetsResponse.detail().toString());
        }
    }

    resource function post asset (@http:Payload Asset asset) returns Asset|error {
        CreateAssetResponse|graphql:ClientError createAssetResponse = globalDataClient->createAsset(asset);
        if(createAssetResponse is CreateAssetResponse) {
            Asset|error asset_record = createAssetResponse.add_asset.cloneWithType(Asset);
            if(asset_record is Asset) {
                return asset_record;
            } else {
                log:printError("Error while processing Application record received", asset_record);
                return error("Error while processing Application record received: " + asset_record.message() + 
                    ":: Detail: " + asset_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createAssetResponse);
            return error("Error while creating application: " + createAssetResponse.message() + 
                ":: Detail: " + createAssetResponse.detail().toString());
        }
    }

    resource function put asset (@http:Payload Asset asset) returns Asset|error {
        UpdateAssetResponse|graphql:ClientError updateAssetResponse = globalDataClient->updateAsset(asset);
        if(updateAssetResponse is UpdateAssetResponse) {
            Asset|error asset_record = updateAssetResponse.update_asset.cloneWithType(Asset);
            if(asset_record is Asset) {
                return asset_record;
            } else {
                log:printError("Error while processing Application record received", asset_record);
                return error("Error while processing Application record received: " + asset_record.message() + 
                    ":: Detail: " + asset_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateAssetResponse);
            return error("Error while updating application: " + updateAssetResponse.message() + 
                ":: Detail: " + updateAssetResponse.detail().toString());
        }
    }

    resource function get supplier (int supplierId) returns Supplier|error {
        GetSupplierResponse|graphql:ClientError getSupplierResponse = globalDataClient->getSupplier(supplierId);
        if(getSupplierResponse is GetSupplierResponse) {
            Supplier|error supplier = getSupplierResponse.supplier.cloneWithType(Supplier);
            if(supplier is Supplier) {
                return supplier;
            } else {
                log:printError("Error while processing Application record received", supplier);
                return error("Error while processing Application record received: " + supplier.message() + 
                    ":: Detail: " + supplier.detail().toString());
            }
        } else {
            log:printError("Error while getting application", getSupplierResponse);
            return error("Error while getting application: " + getSupplierResponse.message() + 
                ":: Detail: " + getSupplierResponse.detail().toString());
        }
    }

    resource function get suppliers () returns Supplier[]|error {
        GetSuppliersResponse|graphql:ClientError getSuppliersResponse = globalDataClient->getSuppliers();
        if(getSuppliersResponse is GetSuppliersResponse) {
            Supplier[] suppliers = [];
            foreach var supplier in getSuppliersResponse.suppliers {
                Supplier|error supplier_record = supplier.cloneWithType(Supplier);
                if(supplier_record is Supplier) {
                    suppliers.push(supplier_record);
                } else {
                    log:printError("Error while processing Application record received", supplier_record);
                    return error("Error while processing Application record received: " + supplier_record.message() + 
                        ":: Detail: " + supplier_record.detail().toString());
                }
            }

            return suppliers;
            
        } else {
            log:printError("Error while getting application", getSuppliersResponse);
            return error("Error while getting application: " + getSuppliersResponse.message() + 
                ":: Detail: " + getSuppliersResponse.detail().toString());
        }
    }

    resource function post supplier (@http:Payload Supplier supplier) returns Supplier|error {
        AddSupplierResponse|graphql:ClientError createSupplierResponse = globalDataClient->addSupplier(supplier);
        if(createSupplierResponse is AddSupplierResponse) {
            Supplier|error supplier_record = createSupplierResponse.add_supplier.cloneWithType(Supplier);
            if(supplier_record is Supplier) {
                return supplier_record;
            } else {
                log:printError("Error while processing Application record received", supplier_record);
                return error("Error while processing Application record received: " + supplier_record.message() + 
                    ":: Detail: " + supplier_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createSupplierResponse);
            return error("Error while creating application: " + createSupplierResponse.message() + 
                ":: Detail: " + createSupplierResponse.detail().toString());
        }
    }

    resource function put supplier (@http:Payload Supplier supplier) returns Supplier|error {
        UpdateSupplierResponse|graphql:ClientError updateSupplierResponse = globalDataClient->updateSupplier(supplier);
        if(updateSupplierResponse is UpdateSupplierResponse) {
            Supplier|error supplier_record = updateSupplierResponse.update_supplier.cloneWithType(Supplier);
            if(supplier_record is Supplier) {
                return supplier_record;
            } else {
                log:printError("Error while processing Application record received", supplier_record);
                return error("Error while processing Application record received: " + supplier_record.message() + 
                    ":: Detail: " + supplier_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateSupplierResponse);
            return error("Error while updating application: " + updateSupplierResponse.message() + 
                ":: Detail: " + updateSupplierResponse.detail().toString());
        }
    }

    resource function get consumable (int consumableId) returns Consumable|error {
        GetConsumableResponse|graphql:ClientError getConsumableResponse = globalDataClient->getConsumable(consumableId);
        if(getConsumableResponse is GetConsumableResponse) {
            Consumable|error consumable = getConsumableResponse.consumable.cloneWithType(Consumable);
            if(consumable is Consumable) {
                return consumable;
            } else {
                log:printError("Error while processing Application record received", consumable);
                return error("Error while processing Application record received: " + consumable.message() + 
                    ":: Detail: " + consumable.detail().toString());
            }
        } else {
            log:printError("Error while getting application", getConsumableResponse);
            return error("Error while getting application: " + getConsumableResponse.message() + 
                ":: Detail: " + getConsumableResponse.detail().toString());
        }
    }

    resource function get consumables () returns Consumable[]|error {
        GetConsumablesResponse|graphql:ClientError getConsumablesResponse = globalDataClient->getConsumables();
        if(getConsumablesResponse is GetConsumablesResponse) {
            Consumable[] consumables = [];
            foreach var consumable in getConsumablesResponse.consumables {
                Consumable|error consumable_record = consumable.cloneWithType(Consumable);
                if(consumable_record is Consumable) {
                    consumables.push(consumable_record);
                } else {
                    log:printError("Error while processing Application record received", consumable_record);
                    return error("Error while processing Application record received: " + consumable_record.message() + 
                        ":: Detail: " + consumable_record.detail().toString());
                }
            }

            return consumables;
            
        } else {
            log:printError("Error while getting application", getConsumablesResponse);
            return error("Error while getting application: " + getConsumablesResponse.message() + 
                ":: Detail: " + getConsumablesResponse.detail().toString());
        }
    }

    resource function post consumable (@http:Payload Consumable consumable) returns Consumable|error {
        AddConsumableResponse|graphql:ClientError createConsumableResponse = globalDataClient->addConsumable(consumable);
        if(createConsumableResponse is AddConsumableResponse) {
            Consumable|error consumable_record = createConsumableResponse.add_consumable.cloneWithType(Consumable);
            if(consumable_record is Consumable) {
                return consumable_record;
            } else {
                log:printError("Error while processing Application record received", consumable_record);
                return error("Error while processing Application record received: " + consumable_record.message() + 
                    ":: Detail: " + consumable_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createConsumableResponse);
            return error("Error while creating application: " + createConsumableResponse.message() + 
                ":: Detail: " + createConsumableResponse.detail().toString());
        }
    }

    resource function put consumable (@http:Payload Consumable consumable) returns Consumable|error {
        UpdateConsumableResponse|graphql:ClientError updateConsumableResponse = globalDataClient->updateConsumable(consumable);
        if(updateConsumableResponse is UpdateConsumableResponse) {
            Consumable|error consumable_record = updateConsumableResponse.update_consumable.cloneWithType(Consumable);
            if(consumable_record is Consumable) {
                return consumable_record;
            } else {
                log:printError("Error while processing Application record received", consumable_record);
                return error("Error while processing Application record received: " + consumable_record.message() + 
                    ":: Detail: " + consumable_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateConsumableResponse);
            return error("Error while updating application: " + updateConsumableResponse.message() + 
                ":: Detail: " + updateConsumableResponse.detail().toString());
        }
    }

    resource function get resource_property (int resourcePropertyId) returns ResourceProperty|error {
        GetResourcePropertyResponse|graphql:ClientError getResourcePropertyResponse = globalDataClient->getResourceProperty(resourcePropertyId);
        if(getResourcePropertyResponse is GetResourcePropertyResponse) {
            ResourceProperty|error resource_property = getResourcePropertyResponse.resource_property.cloneWithType(ResourceProperty);
            if(resource_property is ResourceProperty) {
                return resource_property;
            } else {
                log:printError("Error while processing Application record received", resource_property);
                return error("Error while processing Application record received: " + resource_property.message() + 
                    ":: Detail: " + resource_property.detail().toString());
            }
        } else {
            log:printError("Error while getting application", getResourcePropertyResponse);
            return error("Error while getting application: " + getResourcePropertyResponse.message() + 
                ":: Detail: " + getResourcePropertyResponse.detail().toString());
        }
    }

    resource function get resource_properties () returns ResourceProperty[]|error {
        GetResourcePropertiesResponse|graphql:ClientError getResourcePropertiesResponse = globalDataClient->getResourceProperties();
        if(getResourcePropertiesResponse is GetResourcePropertiesResponse) {
            ResourceProperty[] resource_properties = [];
            foreach var resource_property in getResourcePropertiesResponse.resource_properties {
                ResourceProperty|error resource_property_record = resource_property.cloneWithType(ResourceProperty);
                if(resource_property_record is ResourceProperty) {
                    resource_properties.push(resource_property_record);
                } else {
                    log:printError("Error while processing Application record received", resource_property_record);
                    return error("Error while processing Application record received: " + resource_property_record.message() + 
                        ":: Detail: " + resource_property_record.detail().toString());
                }
            }

            return resource_properties;
            
        } else {
            log:printError("Error while getting application", getResourcePropertiesResponse);
            return error("Error while getting application: " + getResourcePropertiesResponse.message() + 
                ":: Detail: " + getResourcePropertiesResponse.detail().toString());
        }
    }

    resource function post resource_property (@http:Payload ResourceProperty resourceProperty) returns ResourceProperty|error {
        AddResourcePropertyResponse|graphql:ClientError createResourcePropertyResponse = globalDataClient->addResourceProperty(resourceProperty);
        if(createResourcePropertyResponse is AddResourcePropertyResponse) {
            ResourceProperty|error resource_property_record = createResourcePropertyResponse.add_resource_property.cloneWithType(ResourceProperty);
            if(resource_property_record is ResourceProperty) {
                return resource_property_record;
            } else {
                log:printError("Error while processing Application record received", resource_property_record);
                return error("Error while processing Application record received: " + resource_property_record.message() + 
                    ":: Detail: " + resource_property_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createResourcePropertyResponse);
            return error("Error while creating application: " + createResourcePropertyResponse.message() + 
                ":: Detail: " + createResourcePropertyResponse.detail().toString());
        }
    }

    resource function put resource_property (@http:Payload ResourceProperty resourceProperty) returns ResourceProperty|error {
        UpdateResourcePropertyResponse|graphql:ClientError updateResourcePropertyResponse = globalDataClient->updateResourceProperty(resourceProperty);
        if(updateResourcePropertyResponse is UpdateResourcePropertyResponse) {
            ResourceProperty|error resource_property_record = updateResourcePropertyResponse.update_resource_property.cloneWithType(ResourceProperty);
            if(resource_property_record is ResourceProperty) {
                return resource_property_record;
            } else {
                log:printError("Error while processing Application record received", resource_property_record);
                return error("Error while processing Application record received: " + resource_property_record.message() + 
                    ":: Detail: " + resource_property_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateResourcePropertyResponse);
            return error("Error while updating application: " + updateResourcePropertyResponse.message() + 
                ":: Detail: " + updateResourcePropertyResponse.detail().toString());
        }
    }

    resource function get supply (int supplyId) returns Supply|error {
        GetSupplyResponse|graphql:ClientError getSupplyResponse = globalDataClient->getSupply(supplyId);
        if(getSupplyResponse is GetSupplyResponse) {
            Supply|error supply = getSupplyResponse.supply.cloneWithType(Supply);
            if(supply is Supply) {
                return supply;
            } else {
                log:printError("Error while processing Application record received", supply);
                return error("Error while processing Application record received: " + supply.message() + 
                    ":: Detail: " + supply.detail().toString());
            }
        } else {
            log:printError("Error while getting application", getSupplyResponse);
            return error("Error while getting application: " + getSupplyResponse.message() + 
                ":: Detail: " + getSupplyResponse.detail().toString());
        }
    }

    resource function get supplies () returns Supply[]|error {
        GetSuppliesResponse|graphql:ClientError getSuppliesResponse = globalDataClient->getSupplies();
        if(getSuppliesResponse is GetSuppliesResponse) {
            Supply[] supplies = [];
            foreach var supply in getSuppliesResponse.supplies {
                Supply|error supply_record = supply.cloneWithType(Supply);
                if(supply_record is Supply) {
                    supplies.push(supply_record);
                } else {
                    log:printError("Error while processing Application record received", supply_record);
                    return error("Error while processing Application record received: " + supply_record.message() + 
                        ":: Detail: " + supply_record.detail().toString());
                }
            }

            return supplies;
            
        } else {
            log:printError("Error while getting application", getSuppliesResponse);
            return error("Error while getting application: " + getSuppliesResponse.message() + 
                ":: Detail: " + getSuppliesResponse.detail().toString());
        }
    }

    resource function post supply (@http:Payload Supply supply) returns Supply|error {
        AddSupplyResponse|graphql:ClientError createSupplyResponse = globalDataClient->addSupply(supply);
        if(createSupplyResponse is AddSupplyResponse) {
            Supply|error supply_record = createSupplyResponse.add_supply.cloneWithType(Supply);
            if(supply_record is Supply) {
                return supply_record;
            } else {
                log:printError("Error while processing Application record received", supply_record);
                return error("Error while processing Application record received: " + supply_record.message() + 
                    ":: Detail: " + supply_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createSupplyResponse);
            return error("Error while creating application: " + createSupplyResponse.message() + 
                ":: Detail: " + createSupplyResponse.detail().toString());
        }
    }

    resource function put supply (@http:Payload Supply supply) returns Supply|error {
        UpdateSupplyResponse|graphql:ClientError updateSupplyResponse = globalDataClient->updateSupply(supply);
        if(updateSupplyResponse is UpdateSupplyResponse) {
            Supply|error supply_record = updateSupplyResponse.update_supply.cloneWithType(Supply);
            if(supply_record is Supply) {
                return supply_record;
            } else {
                log:printError("Error while processing Application record received", supply_record);
                return error("Error while processing Application record received: " + supply_record.message() + 
                    ":: Detail: " + supply_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateSupplyResponse);
            return error("Error while updating application: " + updateSupplyResponse.message() + 
                ":: Detail: " + updateSupplyResponse.detail().toString());
        }
    }

    resource function get resource_allocation (int resourceAllocationId) returns ResourceAllocation[]|error {
        GetResourceAllocationResponse|graphql:ClientError getResourceAllocationResponse = globalDataClient->getResourceAllocation(resourceAllocationId);
        if(getResourceAllocationResponse is GetResourceAllocationResponse) {
            ResourceAllocation[] resource_allocations = [];
            foreach var resource_allocation in getResourceAllocationResponse.resource_allocation {
                ResourceAllocation|error resource_allocation_record = resource_allocation.cloneWithType(ResourceAllocation);
                if(resource_allocation_record is ResourceAllocation) {
                    resource_allocations.push(resource_allocation_record);
                } else {
                    log:printError("Error while processing Application record received", resource_allocation_record);
                    return error("Error while processing Application record received: " + resource_allocation_record.message() + 
                        ":: Detail: " + resource_allocation_record.detail().toString());
                }
            }

            return resource_allocations;
            
        } else {
            log:printError("Error while getting application", getResourceAllocationResponse);
            return error("Error while getting application: " + getResourceAllocationResponse.message() + 
                ":: Detail: " + getResourceAllocationResponse.detail().toString());
        }
    }

    resource function get resource_allocation_by_person (int personId) returns ResourceAllocation[]|error {
        GetResourceAllocationByPersonResponse|graphql:ClientError getResourceAllocationByPersonResponse = globalDataClient->getResourceAllocationByPerson(personId);
        if(getResourceAllocationByPersonResponse is GetResourceAllocationByPersonResponse) {
            ResourceAllocation[] resource_allocations = [];
            foreach var resource_allocation in getResourceAllocationByPersonResponse.resource_allocation {
                ResourceAllocation|error resource_allocation_record = resource_allocation.cloneWithType(ResourceAllocation);
                if(resource_allocation_record is ResourceAllocation) {
                    resource_allocations.push(resource_allocation_record);
                } else {
                    log:printError("Error while processing Application record received", resource_allocation_record);
                    return error("Error while processing Application record received: " + resource_allocation_record.message() + 
                        ":: Detail: " + resource_allocation_record.detail().toString());
                }
            }

            return resource_allocations;
            
        } else {
            log:printError("Error while getting application", getResourceAllocationByPersonResponse);
            return error("Error while getting application: " + getResourceAllocationByPersonResponse.message() + 
                ":: Detail: " + getResourceAllocationByPersonResponse.detail().toString());
        }
    }

    resource function get resource_allocations () returns ResourceAllocation[]|error {
        GetResourceAllocationsResponse|graphql:ClientError getResourceAllocationsResponse = globalDataClient->getResourceAllocations();
        if(getResourceAllocationsResponse is GetResourceAllocationsResponse) {
            ResourceAllocation[] resource_allocations = [];
            foreach var resource_allocation in getResourceAllocationsResponse.resource_allocations {
                ResourceAllocation|error resource_allocation_record = resource_allocation.cloneWithType(ResourceAllocation);
                if(resource_allocation_record is ResourceAllocation) {
                    resource_allocations.push(resource_allocation_record);
                } else {
                    log:printError("Error while processing Application record received", resource_allocation_record);
                    return error("Error while processing Application record received: " + resource_allocation_record.message() + 
                        ":: Detail: " + resource_allocation_record.detail().toString());
                }
            }

            return resource_allocations;
            
        } else {
            log:printError("Error while getting application", getResourceAllocationsResponse);
            return error("Error while getting application: " + getResourceAllocationsResponse.message() + 
                ":: Detail: " + getResourceAllocationsResponse.detail().toString());
        }
    }

    resource function post resource_allocation (@http:Payload ResourceAllocation resourceAllocation) returns ResourceAllocation|error {
        AddResourceAllocationResponse|graphql:ClientError createResourceAllocationResponse = globalDataClient->addResourceAllocation(resourceAllocation);
        if(createResourceAllocationResponse is AddResourceAllocationResponse) {
            ResourceAllocation|error resource_allocation_record = createResourceAllocationResponse.add_resource_allocation.cloneWithType(ResourceAllocation);
            if(resource_allocation_record is ResourceAllocation) {
                return resource_allocation_record;
            } else {
                log:printError("Error while processing Application record received", resource_allocation_record);
                return error("Error while processing Application record received: " + resource_allocation_record.message() + 
                    ":: Detail: " + resource_allocation_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createResourceAllocationResponse);
            return error("Error while creating application: " + createResourceAllocationResponse.message() + 
                ":: Detail: " + createResourceAllocationResponse.detail().toString());
        }
    }

    resource function put resource_allocation (@http:Payload ResourceAllocation resourceAllocation) returns ResourceAllocation|error {
        UpdateResourceAllocationResponse|graphql:ClientError updateResourceAllocationResponse = globalDataClient->updateResourceAllocation(resourceAllocation);
        if(updateResourceAllocationResponse is UpdateResourceAllocationResponse) {
            ResourceAllocation|error resource_allocation_record = updateResourceAllocationResponse.update_resource_allocation.cloneWithType(ResourceAllocation);
            if(resource_allocation_record is ResourceAllocation) {
                return resource_allocation_record;
            } else {
                log:printError("Error while processing Application record received", resource_allocation_record);
                return error("Error while processing Application record received: " + resource_allocation_record.message() + 
                    ":: Detail: " + resource_allocation_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateResourceAllocationResponse);
            return error("Error while updating application: " + updateResourceAllocationResponse.message() + 
                ":: Detail: " + updateResourceAllocationResponse.detail().toString());
        }
    }

    resource function get inventory (int inventoryId) returns Inventory|error {
        GetInventoryResponse|graphql:ClientError getInventoryResponse = globalDataClient->getInventory(inventoryId);
        if(getInventoryResponse is GetInventoryResponse) {
            Inventory|error inventory = getInventoryResponse.inventory.cloneWithType(Inventory);
            if(inventory is Inventory) {
                return inventory;
            } else {
                log:printError("Error while processing Application record received", inventory);
                return error("Error while processing Application record received: " + inventory.message() + 
                    ":: Detail: " + inventory.detail().toString());
            }
        } else {
            log:printError("Error while getting application", getInventoryResponse);
            return error("Error while getting application: " + getInventoryResponse.message() + 
                ":: Detail: " + getInventoryResponse.detail().toString());
        }
    }

    resource function get inventories () returns Inventory[]|error {
        GetInventoriesResponse|graphql:ClientError getInventoriesResponse = globalDataClient->getInventories();
        if(getInventoriesResponse is GetInventoriesResponse) {
            Inventory[] inventories = [];
            foreach var inventory in getInventoriesResponse.inventories {
                Inventory|error inventory_record = inventory.cloneWithType(Inventory);
                if(inventory_record is Inventory) {
                    inventories.push(inventory_record);
                } else {
                    log:printError("Error while processing Application record received", inventory_record);
                    return error("Error while processing Application record received: " + inventory_record.message() + 
                        ":: Detail: " + inventory_record.detail().toString());
                }
            }

            return inventories;
            
        } else {
            log:printError("Error while getting application", getInventoriesResponse);
            return error("Error while getting application: " + getInventoriesResponse.message() + 
                ":: Detail: " + getInventoriesResponse.detail().toString());
        }
    }

    resource function post inventory (@http:Payload Inventory inventory) returns Inventory|error {
        AddInventoryResponse|graphql:ClientError createInventoryResponse = globalDataClient->addInventory(inventory);
        if(createInventoryResponse is AddInventoryResponse) {
            Inventory|error inventory_record = createInventoryResponse.add_inventory.cloneWithType(Inventory);
            if(inventory_record is Inventory) {
                return inventory_record;
            } else {
                log:printError("Error while processing Application record received", inventory_record);
                return error("Error while processing Application record received: " + inventory_record.message() + 
                    ":: Detail: " + inventory_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createInventoryResponse);
            return error("Error while creating application: " + createInventoryResponse.message() + 
                ":: Detail: " + createInventoryResponse.detail().toString());
        }
    }

    resource function put inventory (@http:Payload Inventory inventory) returns Inventory|error {
        UpdateInventoryResponse|graphql:ClientError updateInventoryResponse = globalDataClient->updateInventory(inventory);
        if(updateInventoryResponse is UpdateInventoryResponse) {
            Inventory|error inventory_record = updateInventoryResponse.update_inventory.cloneWithType(Inventory);
            if(inventory_record is Inventory) {
                return inventory_record;
            } else {
                log:printError("Error while processing Application record received", inventory_record);
                return error("Error while processing Application record received: " + inventory_record.message() + 
                    ":: Detail: " + inventory_record.detail().toString());
            }
        } else {
            log:printError("Error while updating application", updateInventoryResponse);
            return error("Error while updating application: " + updateInventoryResponse.message() + 
                ":: Detail: " + updateInventoryResponse.detail().toString());
        }
    }

    resource function get assetByAvinyaType (int avinyaType) returns Asset[]|error {
        GetAssetByAvinyaTypeResponse|graphql:ClientError getAssetByAvinyaTypeResponse = globalDataClient->getAssetByAvinyaType(avinyaType);
        if(getAssetByAvinyaTypeResponse is GetAssetByAvinyaTypeResponse) {
            Asset[] assets = [];
            foreach var asset in getAssetByAvinyaTypeResponse.asset_by_avinya_type {
                Asset|error asset_record = asset.cloneWithType(Asset);
                if(asset_record is Asset) {
                    assets.push(asset_record);
                } else {
                    log:printError("Error while processing Application record received", asset_record);
                    return error("Error while processing Application record received: " + asset_record.message() + 
                        ":: Detail: " + asset_record.detail().toString());
                }
            }

            return assets;
            
        } else {
            log:printError("Error while getting application", getAssetByAvinyaTypeResponse);
            return error("Error while getting application: " + getAssetByAvinyaTypeResponse.message() + 
                ":: Detail: " + getAssetByAvinyaTypeResponse.detail().toString());
        }
    }

    resource function get avinyaTypesByAsset() returns AvinyaType[]|error {
        GetAvinyaTypeByAssetResponse|graphql:ClientError getAvinyaTypesByAssetResponse = globalDataClient->getAvinyaTypeByAsset();
        if(getAvinyaTypesByAssetResponse is GetAvinyaTypeByAssetResponse) {
            AvinyaType[] avinyaTypes = [];
            foreach var avinyaType in getAvinyaTypesByAssetResponse.avinya_types_by_asset {
                AvinyaType|error avinyaType_record = avinyaType.cloneWithType(AvinyaType);
                if(avinyaType_record is AvinyaType) {
                    avinyaTypes.push(avinyaType_record);
                } else {
                    log:printError("Error while processing Application record received", avinyaType_record);
                    return error("Error while processing Application record received: " + avinyaType_record.message() + 
                        ":: Detail: " + avinyaType_record.detail().toString());
                }
            }

            return avinyaTypes;
            
        } else {
            log:printError("Error while getting application", getAvinyaTypesByAssetResponse);
            return error("Error while getting application: " + getAvinyaTypesByAssetResponse.message() + 
                ":: Detail: " + getAvinyaTypesByAssetResponse.detail().toString());
        }
    }
}
