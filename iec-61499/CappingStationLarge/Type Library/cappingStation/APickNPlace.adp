<?xml version="1.0" encoding="UTF-8"?>
<AdapterType Name="APickNPlace" Comment="Adapter Interface">
	<Identification Standard="61499-1">
	</Identification>
	<VersionInfo Version="1.0" Author="az" Date="2018-09-13">
	</VersionInfo>
	<InterfaceList>
		<EventInputs>
			<Event Name="done" Type="Event" Comment="">
			</Event>
			<Event Name="workPosFree" Type="Event" Comment="">
			</Event>
		</EventInputs>
		<EventOutputs>
			<Event Name="reset" Type="Event" Comment="">
			</Event>
			<Event Name="gripp" Type="Event" Comment="">
			</Event>
			<Event Name="insertA" Type="Event" Comment="">
			</Event>
		</EventOutputs>
	</InterfaceList>
	<Service RightInterface="PLUG" LeftInterface="SOCKET" Comment="Adapter Interface">
		<ServiceSequence Name="request_confirm" Comment="">
			<ServiceTransaction>
				<InputPrimitive Interface="SOCKET" Event="REQ" Parameters="REQD"/>
				<OutputPrimitive Interface="PLUG" Event="REQ" Parameters="REQD"/>
			</ServiceTransaction>
			<ServiceTransaction>
				<InputPrimitive Interface="PLUG" Event="CNF" Parameters="CNFD"/>
				<OutputPrimitive Interface="SOCKET" Event="CNF" Parameters="CNFD"/>
			</ServiceTransaction>
		</ServiceSequence>
		<ServiceSequence Name="indication_response" Comment="">
			<ServiceTransaction>
				<InputPrimitive Interface="PLUG" Event="IND" Parameters="INDD"/>
				<OutputPrimitive Interface="SOCKET" Event="IND" Parameters="INDD"/>
			</ServiceTransaction>
			<ServiceTransaction>
				<InputPrimitive Interface="SOCKET" Event="RSP" Parameters="RSPD"/>
				<OutputPrimitive Interface="PLUG" Event="RSP" Parameters="RSPD"/>
			</ServiceTransaction>
		</ServiceSequence>
	</Service>
</AdapterType>
