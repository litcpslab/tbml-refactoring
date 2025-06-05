<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE AdapterType SYSTEM "http://www.holobloc.com/xml/LibraryElement.dtd">
<AdapterType Comment="" Name="ACylinder">
  <Identification Standard="61499-1"/>
  <VersionInfo Author="az" Date="2018-07-09" Version="1.0"/>
  <InterfaceList>
    <EventInputs>
      <Event Comment="Reseting of cylinder performed succesfully" Name="reseted" Type="Event"/>
      <Event Comment="movement performed succesfully" Name="done" Type="Event"/>
      <Event Comment="an error occured during one of the movements" Name="error" Type="Event"/>
    </EventInputs>
    <EventOutputs>
      <Event Comment="put the cylinder into the inital position (default is home)" Name="reset" Type="Event"/>
      <Event Comment="move cylinder into work position" Name="work" Type="Event"/>
      <Event Comment="move cylinder into home position" Name="home" Type="Event"/>
    </EventOutputs>
    <InputVars/>
    <OutputVars/>
  </InterfaceList>
  <Service Comment="" LeftInterface="SOCKET" RightInterface="PLUG">
    <ServiceSequence Comment="" Name="request_confirm">
      <ServiceTransaction>
        <InputPrimitive Event="REQ" Interface="SOCKET" Parameters="REQD"/>
        <OutputPrimitive Event="REQ" Interface="PLUG" Parameters="REQD"/>
      </ServiceTransaction>
      <ServiceTransaction>
        <InputPrimitive Event="CNF" Interface="PLUG" Parameters="CNFD"/>
        <OutputPrimitive Event="CNF" Interface="SOCKET" Parameters="CNFD"/>
      </ServiceTransaction>
    </ServiceSequence>
    <ServiceSequence Comment="" Name="indication_response">
      <ServiceTransaction>
        <InputPrimitive Event="IND" Interface="PLUG" Parameters="INDD"/>
        <OutputPrimitive Event="IND" Interface="SOCKET" Parameters="INDD"/>
      </ServiceTransaction>
      <ServiceTransaction>
        <InputPrimitive Event="RSP" Interface="SOCKET" Parameters="RSPD"/>
        <OutputPrimitive Event="RSP" Interface="PLUG" Parameters="RSPD"/>
      </ServiceTransaction>
    </ServiceSequence>
  </Service>
</AdapterType>
