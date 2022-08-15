# BloodHound

[BloodHound](https://github.com/BloodHoundAD/BloodHound) is an Active Directory reconnaissance tool that can reveal hidden relationships and identify attack paths within an Active Directory or Azure environment. BloodHound documentation can be found [here](https://bloodhound.readthedocs.io/en/latest/index.html) 

The BloodHoundGUI can be installed from the [BloodHound GitHub](https://github.com/BloodHoundAD/BloodHound)

A python based BloodHound ingester can be found [here](https://github.com/fox-it/BloodHound.py). The ingester can be installed with pip `pip install bloodhound`.

Using a set of valid credentials, `bloodhound-python` can be used to enumerate and collect information from the AD domain and provide the data in JSON format. The JSON files provided by the ingester can be beautified with a tool such as `Pretty JSON`.
```shell
bloodhound-python -u csharp -p 111111 -dc dc1.adtest.local --disable-autogc -d adtest.local
```

The JSON files retrieved from the python ingester can be uploaded to a neo4j database using BloodHoundGUI for further analysis of the active directory environment.