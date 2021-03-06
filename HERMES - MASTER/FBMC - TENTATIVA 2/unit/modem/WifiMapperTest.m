%WIFIMAPPERTEST function tests the WifiMapper class
%   This function tests the WIFI mapper considering the modulations: BPSK,
%   QPSK, 16-QAM, 64-QAM and 256-QAM.
%   Mapping test: compares the symbols generated by "map method" to the
%   correct alphabet specified on symbolAlphabet property (defined in
%   IEEE 802.11-2012 and IEEE 802.11ac-2013 standard).
%   LLR calculation test: compare the bits generated by "calculateLlr method" to the
%   original bits used as input on map method.
%
%   Syntax: WifiMapperTest
%
%   Author: Sergio Abreu (SA)
%   Work Address: INDT Manaus
%   E-mail: sergio.abreu@indt.org.br
%   History:
%       v2.0 01 July 2015 - (SA) created
%
%   Copyright (c) 2015 INDT - Institute of Technology Development.
%
%   The program may be used and/or copied only with the written
%   permission of INDT, or in accordance with the terms and conditions
%   stipulated in the agreement/contract under which the program has been
%   supplied.

%% Test 1: check modulation constructor
% Test constructor of WifiMapper class

possibleModOrder = [2, 4, 16, 64, 256];
modulationOrder = possibleModOrder( randi( [1,5] ) );

instanceMapper = modem.WifiMapper ( modulationOrder );
assert( isa ( instanceMapper, 'modem.WifiMapper' ) );

%% Test 2: check map method for BPSK
% Test map methods from WifiMapper class for map BPSK modulation
modulationOrder = 2;
bitsPerSymbol = log2( modulationOrder);
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
% txBits = vec2mat(txBits,1)';
instanceMapper = modem.WifiMapper ( modulationOrder );
modulatedSignal = instanceMapper.map( txBits );
alphabet = instanceMapper.symbolAlphabet{bitsPerSymbol};
error = real(modulatedSignal - alphabet).^2 + ...
        imag(modulatedSignal - alphabet).^2;
assert(sum(error) < 1e-10);

%% Test 3: check map method for QPSK
% Test map methods from WifiMapper class for map QPSK modulation
modulationOrder = 4;
bitsPerSymbol = log2( modulationOrder);
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1)';

instanceMapper = modem.WifiMapper ( modulationOrder );
modulatedSignal = instanceMapper.map( txBits );
alphabet = instanceMapper.symbolAlphabet{bitsPerSymbol};
error = real(modulatedSignal - alphabet).^2 + ...
        imag(modulatedSignal - alphabet).^2;
assert(sum(error) < 1e-10);

%% Test 4: check map method for 16QAM
% Test map methods from WifiMapper class for map 16QAM modulation
modulationOrder = 16;
bitsPerSymbol = log2( modulationOrder);
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1)';
instanceMapper = modem.WifiMapper( modulationOrder );
modulatedSignal = instanceMapper.map( txBits );
alphabet = instanceMapper.symbolAlphabet{bitsPerSymbol};
error = real(modulatedSignal - alphabet).^2 + ...
        imag(modulatedSignal - alphabet).^2;
assert(sum(error) < 1e-10);

%% Test 5: check map method for 64QAM
% Test map methods from WifiMapper class for map 64QAM modulation
modulationOrder = 64;
bitsPerSymbol = log2( modulationOrder);
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1)';
instanceMapper = modem.WifiMapper( modulationOrder );
modulatedSignal = instanceMapper.map( txBits );
alphabet = instanceMapper.symbolAlphabet{bitsPerSymbol};
error = real(modulatedSignal - alphabet).^2 + ...
        imag(modulatedSignal - alphabet).^2;
assert(sum(error) < 1e-10);

%% Test 6: check map method for 256QAM
% Test map methods from WifiMapper class for map 256QAM modulation
modulationOrder = 256;
bitsPerSymbol = log2( modulationOrder);
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1)';
instanceMapper = modem.WifiMapper( modulationOrder );
modulatedSignal = instanceMapper.map( txBits );
alphabet = instanceMapper.symbolAlphabet{bitsPerSymbol};
error = real(modulatedSignal - alphabet).^2 + ...
        imag(modulatedSignal - alphabet).^2;
assert(sum(error) < 1e-10);

%% Test 7: check calculateLlr method for BPSK
% Test calculateLlr methods from LteMapper class
modulationOrder = 2;
bits = ( 0: modulationOrder - 1 )';
txBits = de2bi( bits, 'left-msb' );
llrMethod = enum.modem.LlrMethod.LINEAR_APPROXIMATION;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );

modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal );
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));

%% Test 8: check calculateLlr method for QPSK
% Test calculateLlr methods from LteMapper class using QPSK
modulationOrder = 4;
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1);
llrMethod = enum.modem.LlrMethod.LINEAR_APPROXIMATION;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );
modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal );
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));

%% Test 9: check calculateLlr method for 16QAM
% Test calculateLlr methods from LteMapper class using 16QAM
modulationOrder = 16;
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1);
llrMethod = enum.modem.LlrMethod.LINEAR_APPROXIMATION;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );
modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal );
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));

%% Test 10: check calculateLlr method for 64QAM
% Test calculateLlr methods from LteMapper class using 64QAM
modulationOrder = 64;
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1);
llrMethod = enum.modem.LlrMethod.LINEAR_APPROXIMATION;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );
modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal );
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));

%% Test 11: check calculateLlr method for 256QAM
% Test calculateLlr methods from LteMapper class using 256QAM
modulationOrder = 256;
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1);
llrMethod = enum.modem.LlrMethod.LINEAR_APPROXIMATION;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );
modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal );
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));

%% Test 12: check calculateLlr using IDEAL_AWGN from Mapper Class
% Test calculateLlr methods from Mapper class using IDEAL_AWGN method to
% calculate LLR
possibleModOrder = [2, 4, 16, 64, 256];
modulationOrder = possibleModOrder( randi( [1,5] ) );
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1);
llrMethod = enum.modem.LlrMethod.IDEAL_AWGN;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );
modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal );
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));

%% Test 13: check calculateLlr using NEAREST_AWGN from Mapper Class
% Test calculateLlr methods from Mapper class using NEAREST_AWGN method to
% calculate LLR
possibleModOrder = [2, 4, 16, 64, 256];
modulationOrder = possibleModOrder( randi( [1,5] ) );
bits = ( 0: modulationOrder - 1 );
txBits = de2bi( bits, 'left-msb' );
txBits = vec2mat(txBits,1);
llrMethod = enum.modem.LlrMethod.NEAREST_AWGN;
instanceMapper = modem.WifiMapper( modulationOrder );
instanceMapper.setLlrMethod( llrMethod );
modulatedSignal = instanceMapper.map( txBits );
demodulatedSignal = instanceMapper.calculateLlr( modulatedSignal);
rxBits = ( demodulatedSignal > 0 );
assert(isequal( rxBits, txBits ));