/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cart;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author PHT
 */
public class Cart {
    private Map<Integer,Item> map;

    public Cart() {
        this.map = new HashMap<>();
    }
    
    public void add(Item item){
        int id = item.getId();
        if(this.map.keySet().contains(id)){
            //nếu trong map đã có item thì tăng quantity
            Item currentItem = this.map.get(id);
            currentItem.setQuantity(currentItem.getQuantity()+item.getQuantity());
        }else{
            //nếu trong map chưa có item thì thêm item vào map
            this.map.put(id, item);
        }
    }
    
    public Collection<Item> getItems(){
        return this.map.values();
    }
    
    public double getTotal(){
        double total = 0;
        for(Item item:this.map.values()){
            total += item.getCost();
        }
        return total;
    }
    
    public void empty(){
        this.map.clear();
    }
    
    public void remove(int id){
        this.map.remove(id);
    }
}
