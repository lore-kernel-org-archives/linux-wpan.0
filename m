Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55262 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292AbcGMK40 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 13 Jul 2016 06:56:26 -0400
Subject: Re: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan
 implementation
References: <20160711195044.25343-1-aar@pengutronix.de>
 <CABBYNZJFStOf6qOcpP6DmdxFBx7swrnFPmQLizy0UyokwS64ng@mail.gmail.com>
 <5b41b0e5-c017-20d9-c94f-11fb1ab2847d@pengutronix.de>
 <9025f3ab-9b4d-5120-d078-35b6df5b8beb@pengutronix.de>
 <CABBYNZJKzwJf_dRgLwPbRnZccutkXPcAoj7R2HYMhKTp4HCBhQ@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <bfd7834e-8f1c-32d4-bf1c-aabacbf1a040@pengutronix.de>
Date: Wed, 13 Jul 2016 12:56:10 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZJKzwJf_dRgLwPbRnZccutkXPcAoj7R2HYMhKTp4HCBhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>


Hi,

On 07/13/2016 12:13 PM, Luiz Augusto von Dentz wrote:
> Hi Alex,
> 
> On Wed, Jul 13, 2016 at 12:12 PM, Alexander Aring <aar@pengutronix.de> wrote:
>>
>> Hi,
>>
>> On 07/12/2016 08:35 PM, Alexander Aring wrote:
>>>
>>> Hi,
>>>
>>> On 07/12/2016 04:51 PM, Luiz Augusto von Dentz wrote:
>>> ...
>>>>>
>>>>> HOW TO REPRODUCE:
>>>>>
>>>>> It's simple, do some high payloads which makes lot tx/rcv traffic on both sides:
>>>>>
>>>>> Node A:
>>>>>
>>>>>  ping6 $IP_NODEB%6lo0 -s 60000
>>>>>
>>>>> Node B:
>>>>>
>>>>>  ping6 ff02::1%6lo0
>>>>
>>>> Im not sure I understand what you are trying to do with a packet of
>>>> 60Kb, the l2cap_chan can most likely only do 1280 bytes and even with
>>>
>>> 60Kb is just some incredible high value to produce on both sides tx/rx
>>> data. The other side will normally send some "defragmentation failure"
>>> icmp messages.
>>>
>>> This value is just to produce the high traffic, not practice payload.
>>>
>>>> fragmentation this will consume the credits quicker than we can
>>>> receive more so it will eventually starting buffering until it gets
>>>> stuck. Note that it is probably still receiving credits but we
>>>
>>> This is exactly what I like to do. Produce a lot of data to kill L3
>>> layer, but this should not kill the L2 layer. Killing the L2 layer is
>>> what's happend here.
>>>
>>> If I do a lot of data on e.g. tcp traffic and the tcp connection will be
>>> closed -> that's fine for me but afterwards starting a new L3 connection
>>> should be still working. This is not the case here, I can kill L2 layer
>>> and nothing works anymore, because L2 running into deadlock.
>>>
>>>> probably have so much data buffered that all the credits are consumed
>>>> almost immediately after receiving, or you don't see -EAGAIN more than
>>>> once?
>>>>
>>>
>>> My example shows that we transmit some data on both nodes, that is
>>> important to check the l2cap_chan_send return type.
>>>
>>> When I do that above and running into the deadlock the IPv6 connection
>>> runs "NS" messages only, because it still can send on L3 layer but the
>>> L2 layer is killed -> I get -EAGAIN in l2cap_chan_send always on both
>>> nodes because tx_credits are on both nodes zero and will not be
>>> incremented again.
>>>
>>> So far I know these tx_credits will be incremented only if somebody
>>> sends something again, right? This will never be the case again and I am
>>> stucked in a deadlock which should not be there.
>>>
>>> to your question:
>>>
>>> "or you don't see -EAGAIN more than once"
>>>
>>> I see -EAGAIN always at calling l2cap_chan_send on both nodes. I think I
>>> can wait forever, after an year I still see "-EAGAIN" when calling
>>> l2cap_chan_send.
>>>
>>> Nevertheless, I will try to hit the deadlock (-EAGAIN) on both nodes so
>>> nobody transmits anything anymore. Then waiting six hours and look if
>>> still -EAGAIN is there on both nodes. I will report again here, after
>>> that time it should working again, but I don't believe that.
>>>
>>
>> I waited about ~ 6hours, deadlock was still there.
>>
>> Node A:
>>
>> transmit return value -11
>> send 6lo0 failed chan f617cc00
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
>> transmit return value -11
>> send 6lo0 failed chan f617cc00
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
>> transmit return value -11
>> send 6lo0 failed chan f617cc00
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
>> transmit return value -11
>> send 6lo0 failed chan f617cc00
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
>> transmit return value -11
>> send 6lo0 failed chan f617cc00
>>
>> Node B:
>>
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:6b:3b:1f
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:68:c1:76 type 1 src: 5c:f3:70:6b:3b:1f chan f62aac00
>> transmit return value -11
>> send 6lo0 failed chan f62aac00
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:6b:3b:1f
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:68:c1:76 type 1 src: 5c:f3:70:6b:3b:1f chan f62aac00
>> transmit return value -11
>> send 6lo0 failed chan f62aac00
>> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:6b:3b:1f
>> xmit 6lo0 starts multicasting
>> l2cap_chan_send 6lo0 dst: 5c:f3:70:68:c1:76 type 1 src: 5c:f3:70:6b:3b:1f chan f62aac00
>> transmit return value -11
>> send 6lo0 failed chan f62aac00
> 
> Are there any calls to channel resume?
> 

I also activate debug in l2cap_sock.c now. I captued on node which calls
the ping6 with high payload only.

The first dump shows:

- Queueing lot of IPv6 fragments, because -s 60000
- L2CAP sends first fragment "return value 1246" and drop all others.

This seems to be normal behaviour.

Shown as:

lowpan_chan_resume: chan f54c1800
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 2
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 3
...
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
chan f54c1800, msg f686be64, len 1246
chan f54c1800 len 228
chan f54c1800 len 230
chan f54c1800 len 230
chan f54c1800 len 230
chan f54c1800 len 230
chan f54c1800 len 98
chan f54c1800, skb f61bda00 len 234 priority 0
transmit return value 1246
chan f54c1800 orig refcnt 51
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
...
MANY -EAGAIN stuff until xmit is finished on L3 side.

The first fragment (IPv6 fragment!) "len 1246" was sent successful. All
others are -EAGAIN, because channel is full (tx_credits is 0).

---

Now after that L3 wants to sent another "ping request", but there is no
"resume" callback before. Seems there is also some NS/NA messages in the
middle, but should not be important.

The different here, no "resume callback" anymore and sending first
fragment (IPv6) on l2cap_chan_send will end directly in -EAGAIN, and I
cannot transmit anything anymore.

Shown in:

chan f54c1800 orig refcnt 3
conn f6183400 len 27 flags 0x2
Start: total len 69, frag len 27
conn f6183400 len 27 flags 0x1
Cont: frag len 27 (expecting 42)
conn f6183400 len 15 flags 0x1
Cont: frag len 15 (expecting 15)
len 65, cid 0x0040
chan f54c1800, len 65
rx_credits 10 -> 9
Start of new SDU. sdu_len 63 skb->len 63 imtu 1280
recv 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
conn f6183400 len 27 flags 0x2
Start: total len 77, frag len 27
conn f6183400 len 27 flags 0x1
Cont: frag len 27 (expecting 50)
conn f6183400 len 23 flags 0x1
Cont: frag len 23 (expecting 23)
len 73, cid 0x0040
chan f54c1800, len 73
rx_credits 9 -> 8
Start of new SDU. sdu_len 71 skb->len 71 imtu 1280
recv 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 2
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 3
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
...
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 51
...
MANY -EAGAIN stuff until xmit is finished on L3 side.

Here it directly starts at the first transmit with returning "-11".

---

I didn't capture now the other side. If you like I can also do that, I
think this one shows enough. In the middle of the two log snippets I run
somehow into the deadlock.

Here the complete log which shows the behaviour

 - chan resume called
 - lowpan xmit callback will start lot of xmit workers (maybe can be optimized,
   that we don't queue stuff because queue is full... but I would try
   everything and let l2cap_chan_send decide at least, this is more the
   way to say "send what we can")
 - Then first fragment (IPv6) will be send, after that all IPv6
   fragments sends -EAGAIN.
 - Next ping request will be send.
   - important here, no resume callback occured
   - I am stucked on this node on -EAGAIN, the other node will follow
     to stuck in -EAGAIN.

:

lowpan_chan_resume: chan f54c1800
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 2
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 3
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 4
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 5
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 6
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 7
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 8
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 9
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 10
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 11
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 12
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 13
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 14
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 15
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 16
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 17
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 18
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 19
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 20
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 21
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 22
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 23
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 24
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 25
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 26
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 27
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 28
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 29
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 30
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 31
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 32
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 33
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 34
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 35
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 36
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 37
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 38
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 39
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 40
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 41
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 42
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 43
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 44
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 45
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 46
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 47
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 48
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 49
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
chan f54c1800, msg f686be64, len 1246
chan f54c1800 len 228
chan f54c1800 len 230
chan f54c1800 len 230
chan f54c1800 len 230
chan f54c1800 len 230
chan f54c1800 len 98
chan f54c1800, skb f61bda00 len 234 priority 0
transmit return value 1246
chan f54c1800 orig refcnt 51
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 49
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 48
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 47
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 46
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 45
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 44
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 43
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 42
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 41
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 40
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 39
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 38
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 37
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 36
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 35
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 34
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 33
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 32
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 31
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 30
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 29
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 28
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 27
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 26
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 25
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 24
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 23
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 22
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 21
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 20
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 19
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 18
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 17
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 16
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 15
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 14
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 13
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 12
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 11
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 10
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 9
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 8
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 7
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 6
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 5
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 4
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 3
conn f6183400 len 27 flags 0x2
Start: total len 69, frag len 27
conn f6183400 len 27 flags 0x1
Cont: frag len 27 (expecting 42)
conn f6183400 len 15 flags 0x1
Cont: frag len 15 (expecting 15)
len 65, cid 0x0040
chan f54c1800, len 65
rx_credits 10 -> 9
Start of new SDU. sdu_len 63 skb->len 63 imtu 1280
recv 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
conn f6183400 len 27 flags 0x2
Start: total len 77, frag len 27
conn f6183400 len 27 flags 0x1
Cont: frag len 27 (expecting 50)
conn f6183400 len 23 flags 0x1
Cont: frag len 23 (expecting 23)
len 73, cid 0x0040
chan f54c1800, len 73
rx_credits 9 -> 8
Start of new SDU. sdu_len 71 skb->len 71 imtu 1280
recv 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 2
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 3
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 2
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 3
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 4
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 5
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 6
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 7
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 8
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 9
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 10
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 11
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 12
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 13
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 14
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 15
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 16
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 17
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 18
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 19
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 20
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 21
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 22
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 23
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 24
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 25
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 26
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 27
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 28
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 29
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 30
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 31
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 32
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 33
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 34
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 35
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 36
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 37
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 38
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 39
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 40
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 41
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 42
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 43
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 44
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 45
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 46
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 47
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 48
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 49
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 51
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 50
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 49
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 48
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 47
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 46
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 45
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 44
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 43
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 42
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 41
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 40
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 39
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 38
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 37
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 36
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 35
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 34
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 33
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 32
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 31
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 30
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 29
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 28
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 27
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 26
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 25
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 24
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 23
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 22
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 21
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 20
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 19
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 18
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 17
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 16
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 15
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 14
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 13
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 12
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 11
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 10
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 9
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 8
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 7
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 6
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 5
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 4
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 3
conn f6183400 len 27 flags 0x2
Start: total len 77, frag len 27
conn f6183400 len 27 flags 0x1
Cont: frag len 27 (expecting 50)
conn f6183400 len 23 flags 0x1
Cont: frag len 23 (expecting 23)
len 73, cid 0x0040
chan f54c1800, len 73
rx_credits 8 -> 7
Start of new SDU. sdu_len 71 skb->len 71 imtu 1280
recv 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76
chan f54c1800 orig refcnt 2
l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f54c1800
transmit return value -11
send 6lo0 failed chan f54c1800
chan f54c1800 orig refcnt 3
xmit ndisc 6lo0 dst: 5c:f3:70:6b:3b:1f src: 5c:f3:70:68:c1:76


>> ---
>>
>> They simple show the same stuff, but with different addresses.
>>
>> I rethink about your words and I suppose you told me that tx_credits and
>> -EAGAIN are normal that this stuff occurs.
>>
>> I agree, It also occurs before when I run:
>>
>> ping6 $IP_NODEB%6lo0 -s 60000
>>
>> which is normal. But what should not happen is that there is some little
>> tiny window (race) that both tx_credits are reached to zero and then
>> nobody transmit anything anymore, that's the tx deadlock which I hit here.
>>
>> And this deadlock occurs that I killed the L2CAP chan connection. I
>> think it will work when I create a new chan (because new tx_credits).
>> The connection isn't broken, I just can not transmit anything because tx_credits.
> 
> If there is no calls to channel resume then yes there is a problem
> that no tx_credits would be able to be sent, note though that the
> command the restore credits does happen in the signalling channel not
> in the data channel so there should be anything blocking from

So these are complete separate transmission? Could it be that, because I
do much things on the air that such "tx_credits command" stuff could not
be reached to the other side? Then the complete mechanism can not be
working and maybe need some recovery if no "tx_credits command reached"
some time ago to solve this deadlock?

I am not a bluetooth expert, maybe there exists nicer solutions. :-)

> receiving those, perhaps looking into what is happening the last time
> it receives credits and the sequence of calls it generate.
> 

See above, I hope that helps.

- Alex
