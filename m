Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36617 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbcGRI7k (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Jul 2016 04:59:40 -0400
MIME-Version: 1.0
In-Reply-To: <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-21-aar@pengutronix.de>
 <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de> <CABBYNZL0xFGcW_t-eW9hAL8VOLnp4NYL_iKqChJ8B0srBdEgvQ@mail.gmail.com>
 <11469f72-fa15-5545-387c-ecd051b74897@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Jul 2016 11:59:36 +0300
Message-ID: <CABBYNZ+A54MQ3uWGjDVXNOwwX3v3VptZz2UQUNV4_KFKPaV==A@mail.gmail.com>
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new implementation
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>

Hi Alex,

On Sun, Jul 17, 2016 at 6:52 PM, Alexander Aring <aar@pengutronix.de> wrote:
>
> Hi,
>
> On 07/14/2016 01:40 PM, Luiz Augusto von Dentz wrote:
>> Hi Alex,
>>
>> On Wed, Jul 13, 2016 at 12:19 AM, Alexander Aring <aar@pengutronix.de> wrote:
>>>
>>> Hi,
>>>
>>> On 07/11/2016 09:50 PM, Alexander Aring wrote:
>>>> This patch adds a new btle 6lowpan implementation in version 0.2. This
>>>> new implementation has a new userspace API for debugfs.
>>>>
>>>> It's now possible to decide on which hci interface do you want to run
>>>> your 6LoWPAN interface, for that you can run:
>>>>
>>>> echo "hci0 1" > /sys/kernel/debug/bluetooth/6lowpan_enable
>>>>
>>>> to enable, or:
>>>>
>>>> echo "hci0 0" > /sys/kernel/debug/bluetooth/6lowpan_enable
>>
>> No please no more designs for debugfs, we are past that and moving
>> towards having proper management commands, so what you did here is a
>> huge waste of time and you have instead just ask before hand.
>>
>
> The first time when I used BTLE 6LoWPAN I complaint about that I can not
> say "use this special hci%d for lowpan interface xy", I did that not on
> the mailinglist it was on the irc channel and everybody agreed that it
> need to be fixed. The basic idea on my side was to run only one Virtual
> Machine with two BTLE usb dongles to communicate to each other, so I
> needed to switch to two virtual machines to workaround this issue.
>
> If you have the current debugfs UAPI 1:1 already in some kind of stable
> bluetooth API then I would give you the BIG advice to fix that and let
> me look into that. (As far I know there exists idea's only, no
> implementations).

There is the patches posted by Patrik implementing the management interface:

http://www.spinics.net/lists/linux-bluetooth/msg66486.html

Note that these commands are per interface index, so you would be able
to have two dongle talking to each other, we could in fact even
automate this to test with 2 virtual controllers.

> Another really BIG thing is (it comes to the direction "breaking UAPI"
> as well) that the interface depends on if Slaves are connected. So if
> the last Slave will be disconnected then the interface will be deregistered.
> Every IPv6 userspace application cannot deal with that. The interface
> lifetime must not depend on if slaves connected or not.

This is tricky because the even using privacy the address of the
interface is defined by the time the connection is established, but
perhaps there is a way to set this properly on the network interface,
anyway I do agree the making the interface persistent is probably much
more convenient.

> At this case, I think every netdev people would agree.
>
>>>> to disable it. A cat on this file will show the current hci <-> 6lowpan
>>>> interface mapping.
>>>>
>>>> Additional the different is, that the interface will be created after
>>>> enable it. The old behaviour is that the interface will be created when
>>>> one first connection is established and deleted after all connections
>>>> (peers) will be disconnected. This handling is different now.
>>>>
>>>> The reason (in my opinion) is that the existing of such interface should
>>>> not based on if there is a connection or not. At runtime of many IPv6
>>>> application an interface will be removed -> I think the most userspace
>>>> application can and will never handle that an IPv6 interface will be
>>>> deleted and recreating during runtime.
>>>>
>>>> The new handling is that the interface will not removed and you can
>>>> re-establish the connection to your peers.
>>>>
>>>> Connection to peers:
>>>>
>>>> Connection to peers are not binded to hci interface, it's binded to your
>>>> 6LoWPAN interface. This will prepare handling for multiple 6LoWPAN
>>>> interfaces on one hci (maybe also with netns support, which isn't
>>>> available yet) and you can choose which peers should be handled by
>>>> different BTLE 6LoWPAN interfaces. Example:
>>>>
>>>> L2: hci0 is connected to node A, B, C, D
>>>>
>>>> L3: 6lo0 and 6lo1 are two interfaces based on hci0.
>>>>     6lo0 is connected to nodes: A, B, C
>>>>     6lo1 is connected to nodes: D, C, B
>>
>> Is this is useful for what exactly? I much rather have a simple module
>> that just deal with 1 connection than have to deal with complex
>> topology in the beginning, so this is moving in the exact opposite
>> direction.
>>
>
> Well, I learned now to not talking about crazy use-cases which you could
> do with that. I need more to talk about why this is really needed. I
> will do that in future.

It is about priorities, we should concentrate in making it work for
simpler cases, besides the RFC don't talk about subnets either.


> I observed, what I explained above. There exists two "connect" mechanism,
> these are L2 and L3.
>
> With L2 I mean $FIND_OUT_RIGHT_NOT_DEPRECATED_TOOL_IN_BT_UTILITY_DSCHUNGEL
> leadv/lecc stuff. This prepares somehow that you can say
> l2cap_chan_connect in the upper-layer to connect to slaves.
>
> With l2cap_chan_connect I mean L3 connection, which is the same like
> what you doing in L2 for L3. It's also not be a MUST, because you can
> run e.g. above example Node A, B, C, D on L2 and:
>
> BTLE 6LoWPAN: A <-> B
>
> L2CAP_SOCK:   C <-> D
>
> or some other mixed scenario. I think you want to still have such behaviour.
> This would be the same like: A, B, C, D and 6lo0 is connected to A, B.
> Forget the C, D, make with them whatever you want (_maybe_ namespace with
> C, D or l2cap_sock).

Im not sure where you are going with l2cap_sock here, yes we can make
it connect to different peers but usually each peer assumes a role in
BLE, the central role scans and connect and the peripheral only
advertise. If you do have more than one controller it should be fine
to have multiple network interfaces and then perhaps you can bridge
them together, or not, but this should be controlled via userspace,
the kernel shall only manage the network interface.

> At least if you want to have netns support with mutliple lowpan then
> there will nothing to complex, it's just the same interface handling
> like having one interface in init_net namespace. Just you can deal with
> different namespaces with that (UAPI need to support namespaces for that).
>
> It makes completely more sense to say to "lowpan interface 6lo%d connect
> to slave xy".
>
> The current way is that the user has no control of it and
> l2cap_chan_connect call this "hci_get_route" function behind and with
> bluetooth magic the user get one hci interface which best-fits and maybe
> not that what you want.

See http://www.spinics.net/lists/linux-bluetooth/msg66495.html, it
takes the index of the interface upfront so you can specify which
adapter to use so it shouldn't rely on hci_get_route anymore.

>>>> To connect to peers, there exists no "6lowpan_control" anymore. The
>>>> control file is now peer interface, it's simple:
>>>>
>>>> echo "connect $PEER_ADDRESS 1" > /sys/kernel/debug/bluetooth/6lo0
>>>>
>>>> Also after connecting to peers it's still possible that another peer can
>>>> to connect to the peer which has already a connected peer (complicated
>>>> to describe). I saw that is somehow disabled in version before, see:
>>>>
>>>> http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L1247
>>>>
>>>> I am not a bluetooth expert, but I guess that is somehow if there exists
>>>> limitation to devices which are not "peers" that means devices which can
>>>> be run as master or slave only. So far I know such limitations for
>>>> devices doesn't exists for BTLE 6LoWPAN, or?
>>>>
>>
>> I guess that is because dual role is not specified, you either are a
>> node or a router but not both at the same time.
>>
>
> Okay, then I will close the "listen" l2cap channel after somebody did a
> connect. But I bet there was some graphic somewhere which had a
>
> SLAVE.... <---- MASTER <----> MASTER ----> SLAVE...
>
> So with that we forbid such MASTER <-> MASTER connections.

This master to master connection doesn't make much sense, usually a
central cannot connect to another central since none advertise
anything, but indeed we can have more than one slave/none connected to
a master/router. Note we can in fact switch between peripheral and
central roles, so in theory it is still possible to have subnets, but
it is just very unlikely.

>>> I think the following will explain somehow when it's a SLAVE and when
>>> MASTER as my current view.
>>>
>>> SLAVES:
>>>
>>> They don't makes this echo "connect ..." foo in control files.
>>> they only do "hciconfig hci0 leadv" that somebody other can connect to
>>> that node (some MASTER node).
>>>
>>> MASTERS:
>>>
>>> can do the same what the SLAVES does but to be as MASTER they need to call
>>> additional stuff:
>>>
>>> hcitool lecc $SLAVE_ADDR (one or more times)
>>
>> Don't use hcitool, actually never mention any of hci related
>> interfaces on the patches there are deprecated, btmgmt shall be used
>> to enable things like advertising, I will be working on adding
>> advertising support for bluetoothctl but we actually need IPSP UUID
>> support in order to make this work properly so not even btmgmt will be
>> enough in the end.
>>
>
> Yes, Marcel already told me some tools are deprecated and I should not
> use them. You don't want to know how long I took when I had some working
> setup with my broadcom dongles. :-)
>
> I am too lazy to switch, I will use now btmgmt. I hope it can do the
> same suff up/down (I think power on/off) and leadv and lecc.

Yes, but if we keep using those people will never learn there deprecated.

>
>>> Additional for different lowpan interfaces (don't need the same addresses
>>> which was used by previous one or more hcitool lecc calls):
>>>
>>> echo "connect SLAVE_ADDR 1" > /sys/kernel/debug/bluetooth/6lo0
>>>
>>> is this a correct view and can all BTLE transceivers run as SLAVE or
>>> MASTER, or exists there some special transceivers outside which can be
>>> run as SLAVE only?
>>>
>>>> Nevertheless I disabled that stuff, it's still possible to connect to
>>>> some node which already run "connect ..." on his side.
>>>>
>>>> Otherwise I fixed the ndisc stuff and removed a lot of races/side
>>>> effects. The old code had some static "lowpan_devices" list and most
>>>> time there was some lookup mapping according to bdaddr to get the right
>>>> 6lo netdevice struct. I removed that, also the skb->cb is used a lot in
>>>> some callback which had some side-effects.
>>
>> Send the fixes, and the fixes only.
>>
>
> There exists fixes only, no new features. In my opinion, UAPI is broken
> because you can't control what you want. Again, because "hci_get_route" magic.
> I added no new features, I fixed the broken things. Maybe there are some
> little small cleanups if you say changing function namens is not a
> bugfix it's a cleanup.

See the RFC sent by Patrik, the MGMT commands use interface index so
hci_get_route should not be needed.

> Removing the whole implementation and adding a new one is the only way
> which I would think it is possible, because we need to fix stuff in
> IPHC and as well in IPv6 as well.

I guess these are separate fixes aren't they? Or are they depending on
this patch?

> I know the zephyr people wants to be backwardscompatible I could say, I
> add a big BROKEN_IMPLEMENTATION Kconfig switch which let's you compile
> the old broken version which is still compatible with stacks outside.

No, in fact we need these fixes in order to work properly with zephyr.

> btw: stacks outside I see currently pull-request in RIOT-OS which do the
> same L2 address length is 8 instead 6, which means they are currently
> bug compatible with Linux.

Sounds like a bug there, Bluetooth shall use MAC addresses of 6 bytes
long the conversion for 8 bytes (64 bits) is just for the link local
to form the so called IID (https://tools.ietf.org/html/rfc7668) I
don't think it should be transmitted with 0xff, 0xfe encoded in the
address.

-- 
Luiz Augusto von Dentz
