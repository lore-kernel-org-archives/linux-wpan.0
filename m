Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39730 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811AbcGSVYs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Jul 2016 17:24:48 -0400
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new
 implementation
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-21-aar@pengutronix.de>
 <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de>
 <CABBYNZL0xFGcW_t-eW9hAL8VOLnp4NYL_iKqChJ8B0srBdEgvQ@mail.gmail.com>
 <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de>
 <CABBYNZ+A54MQ3uWGjDVXNOwwX3v3VptZz2UQUNV4_KFKPaV==A@mail.gmail.com>
 <190983bc-9467-8ff8-436c-ca1fcdfe001b@pengutronix.de>
 <CABBYNZK-zzTzy5uUYd1GVgwiNX9MNpAmWpWUbRyAbOqN0fcNdg@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <304c7949-08aa-5ada-a37e-e12b9ab83a2c@pengutronix.de>
Date: Tue, 19 Jul 2016 23:24:34 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZK-zzTzy5uUYd1GVgwiNX9MNpAmWpWUbRyAbOqN0fcNdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>


Hi,

On 07/19/2016 10:49 AM, Luiz Augusto von Dentz wrote:
> Hi Alex,
> 
> On Tue, Jul 19, 2016 at 12:52 AM, Alexander Aring <aar@pengutronix.de> wrote:
>>>> If you have the current debugfs UAPI 1:1 already in some kind of stable
>>>> bluetooth API then I would give you the BIG advice to fix that and let
>>>> me look into that. (As far I know there exists idea's only, no
>>>> implementations).
>>>
>>> There is the patches posted by Patrik implementing the management interface:
>>>
>>> http://www.spinics.net/lists/linux-bluetooth/msg66486.html
>>>
>> Okay, just to be sure here, in the above document:
>>
>> Controller ID = hdev(usually var name, struct hci_dev)->id
>>
>> Interface Index = dev(usualy var name, struct net_device)->idx
>>
>> Is this right? I think so, so my next stuff will base on that.
> 
> Yep.
> 
>>> Note that these commands are per interface index, so you would be able
>>> to have two dongle talking to each other, we could in fact even
>>> automate this to test with 2 virtual controllers.
>>>
>>
>> We have similar automating testing in 802.15.4 6LoWPAN with virtual
>> transceiver drivers.
>>
>> I always looked somehow for some virtual driver in bluetooth, does this
>> exist mainline?
> 
> Take a look at the emulator directory:
> 
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/emulator
> 

cool.

>>> It is about priorities, we should concentrate in making it work for
>>> simpler cases, besides the RFC don't talk about subnets either.
>>>
>>
>> I don't talking about subnets.
>>
>> I am talking about "make the connect command per interface". Patrik
>> works shows the following:
>>
>> Add Network Command
>> ===================
>>
>>         Command Code:           0x0043
>>         Controller Index:       <controller id>
>>         Command Parameters:     Address (6 Octets)
>>                                 Address_Type (1 Octet)
>>         Return Parameters:      Address (6 Octets)
>>                                 Address_Type (1 Octet)
>>                                 Interface Index (4 Octets)
>>
>>         This command is used to connect to establish a network connection
>>         to a remote BTLE node. A pre-requisite is that LE is supported
>>         by the controller, otherwise this command will return a
>>         "not supported" response.
>>
>>         Possible values for the Address_Type parameter:
>>                 0       Reserved
>>                 1       LE Public
>>                 2       LE Random
>>
>>         This command generates a Command Complete event on success
>>         or failure.
>>
>>         Possible errors:        Busy
>>                                 Refused
>>                                 Invalid Parameters
>>                                 Not Supported
>>                                 Invalid Index
>>                                 Already Connected
>>
>> So far I understand, this is "make the connect command per device", the
>> device in this case is not a "struct net_device" it's "struct hci_dev".
>>
>> In the "possible" future case to having multiple interfaces you cannot
>> say on which interface this connect should be done. With "connect" I
>> mean the l2cap_chan_connect call.
> 
> And why would we want more than one one net_dev per hci_dev, the
> rfc7668 only talks about star topology:
> 
> https://tools.ietf.org/html/rfc7668#section-2.2
> 
> Bluetooth currently don't have support for a mesh topology, and anyway
> I don't think the userspace would need to be involved in the selection
> of the netdev since this is beyond the Bluetooth interface. In PAN for
> example we end up doing one netdev per connection and the which the
> userspace managing using a bridge.
> 

I am sure that there will be some use-case with namespaces some day.

In general:

In my opinion, having hci_dev as input parameter and as output the
interface will do something hidden behind which you can't control.
The Output return value "interface" will indicate on which interface
the operation was operated on. For me it's something behind which you
cannot control as user. E.g. When having multiple interfaces. On 1:1
mapping, I agree this should work.

But why not simple drop the interface idx from the Output and move it to
Input?

         Command Code:           0x0043
         Controller Index:       <controller id>
         Command Parameters:     Address (6 Octets)
                                 Address_Type (1 Octet)
                                 Interface Index (4 Octets)
         Return Parameters:      Address (6 Octets)
                                 Address_Type (1 Octet)

If we get some way that the 6LoWPAN interface can be created before and
not when doing the first "connect command" then the "Controller Index"
would be unnecessary because you would give that information when
creating an interface.

>> btw:
>> Also I don't know what's now the parameters "Address/Address_Type"
>> source/destination? Is the Input of them equal to the output?
> 
> That is always the destination address, and we needs its type to know
> if it is public or private to act accordingly.
> 

okay.

- Alex
