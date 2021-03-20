# Conquerors



## Problem Statement

 Timely collection of degradable wastes is a challenge, given the rapid urbanization and increasing density of population in the urban areas. The biodegradable wastes if not collected regularly can pollute the environment and surroundings and can be a major health risk. This paper proposed a cost-effective technique that can detect the garbage on the pavements and decentralized collection points through odor sensing. The proposed system will be fitted in a moving vehicle and consists of a MQ series sensor which detect the foul smell. The sensor is designed to send the information which is a value that indicates the level of toxicity of the smell and location with the help of GPS (Global Positioning System) fitted in the vehicle. The information will be sent with the support of LoRa (Long Range) network and cloud. The smell sensors that detect elementary composition of garbage such as methane, ethanol, acetic acid, benzene, etc. and the vehicle fleeting near the pavements dumped with garbage will sense the smell using sensors and a report is sent to the authorities with its location and its level of toxicity. The location wise level of toxicity will be captured in a master screen would support the authorities in prioritizing the areas to be cleaned up first and would also support in monitoring the results of the action.
 
 ## Introduction
   

* The odor sensing device we proposed in this paper continuously detects, measures, and monitors the odorful gaseous contaminants. 
* The solution incorporates Odor Atmospheric Dispersion Modelling (OADM) for predicting odor impact on the surrounding area depending on meteorological conditions. 
* With the help of meteorological data, the odor sensing device can trace the odorant dispersion plume incited by conditions like wind speed and wind direction.
* The odor sensing device uses LoRa LPWAN (a low-power wide-area network) technology network, which is one of the best cost-effective approaches in such conditions.
* The odor sensor is being implemented by using chemical sensors (MQ-2, MQ-3, MQ-9, MQ-135, etc.), air quality sensors. 
* Whenever the brink point of the chemical sensor is reached, the sensor data is shipped to the LoRa gateway together with the placement (longitude and latitude) of the vehicle. The LoRa main hub is placed every 3-5 km radius. 
* The LoRa receiver receives this data and sends it to the cloud. From the cloud, the municipality can take action to scrub that area.  All this data is shipped to the corporation for the upkeep of cleanliness and keeping the environment clean. 
* In the present scenario, most of the countries the sensors introduced by the Municipal Authorities are static and accordingly, placed only in a few select locations. 
* Given the increased attention to cleanliness amongst the cities (like Swachh Bharat Abhiyan (Clean India Mission) and Ranking of Cities based on cleanliness in India), the project can support relevant authorities for ensuring better living conditions by reducing the hazardous odor and timely waste collection by using the proposed system which can be a moving sensor that can detect the foul smell in any part of the cities.
![image](https://user-images.githubusercontent.com/56267948/111866602-a6b55980-8994-11eb-81c0-58f956ade8ae.png)


## Hardware Requirements
1.Heltec ESP32 

![image](https://user-images.githubusercontent.com/56267948/111869202-37dffc80-89a4-11eb-8e66-d0d602b2f506.png)


ESP32 can perform as a complete standalone system or as a slave device to a host MCU, reducing communication stack overhead on the main application processor. ESP32 can interface with other systems to provide Wi-Fi and Bluetooth functionality through its SPI / SDIO or I2C / UART interfaces.

2.  MQ Series Sensor
   
   ![image](https://user-images.githubusercontent.com/56267948/111869540-1122c580-89a6-11eb-88d7-4be8ac154b9b.png)


Gas sensors (also known as gas detectors) are electronic devices that detect and identify different types of gasses. They are commonly used to detect toxic or explosive gasses and measure gas concentration. Gas sensors are employed in factories and manufacturing facilities to identify gas leaks, and to detect smoke and carbon monoxide in homes.
  
 
                                                                                                                                                               







