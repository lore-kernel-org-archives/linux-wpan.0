Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38234 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755041AbcFPVi1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 16 Jun 2016 17:38:27 -0400
Subject: Re: current btle 6lowpan issues
References: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de>
 <1466071258.31678.12.camel@linux.intel.com>
 <1466084491.13892.99.camel@linux.intel.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <594d0734-87d2-2cbf-716b-2c3b0ac97ac6@pengutronix.de>
Date: Thu, 16 Jun 2016 23:38:24 +0200
MIME-Version: 1.0
In-Reply-To: <1466084491.13892.99.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Patrik Flykt <Patrik.Flykt@linux.intel.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de


Hi,

On 06/16/2016 03:41 PM, Patrik Flykt wrote:
> On Thu, 2016-06-16 at 13:00 +0300, Jukka Rissanen wrote:
>> Yes you are right that there are issues. Fortunately the bt0 is
>> currently a point-to-point link in which case ND is not really done
>> and everything kind of "works" ok.
>>
>> I added Patrik to cc: as he has been working to fix the issues but
>> the patches are not yet ready. Perhaps we could combine the efforts
>> here.
> 
> I had some patches that make BTLE interfaces non-point-to-point. Let me
> check that they can be applied on the latest bluetooth-next and that
> they still compile after a few months of sitting on an old version.
> Then let's hope they also work as expected...
> 

With non-point-to-point you mean to remove the IFF_POINTOPOINT flag in
net_device? Yes this should be removed.

But I think this is one of the smallest issue in btle 6lowpan.

What means "ND is not really done", does that means you will not see
btle neighbours by doing "ip -6 neigh" for your bt interface?

I don't believe that and I think no matter if you set IFF_POINTOPOINT or
not, the IPv6 stack will mostly ignore such flag. I did a grep and it
seems the SIT stuff sets this flag and IPv6 stack does something with
that, but not in case of ARPHRD_6LOWPAN, it's for ARPHRD_SIT only. So I
think this flag makes some "peer" address in "ip a" handling instead of
showing broadcast address. But nobody will make special handling in IPv6
or btle 6lowpan if this flag is set.

What I mean is, you can set this flag on or off but it will don't change
any behaviour.

---

Back to the two issues which I mentioned. I suppose "ip -6 neigh" shows
currently some neighbours or not? I don't believe, that IPv6 can
working without any neighbours in "ip -6 neigh", otherwise the IPv6
stack would send NS messages again and again. (Because 2. issue the
addresses in ndisc is not be the 6-byte address of bluetooth device, it's
the fffe with u/l bit flip stuff, which is the /64 prefix of
autoconfiguration L3 address which is wrong.)

These NS messages have some multicast address as L3 daddr and so far I
know, it should be working like the following example: 
(correct me if I am wrong)

         _____ Slave #1 (6LN)
        /
Master #0 (6LBR)
        \----- Slave #2 (6LN)
	 \
	  \--- Slave #n (6LN)
	   \
	    \- ... (6LN)
	     .
	      .
	       .

So if one Slave multicast address as destination, the master need to
send to all Slaves the same 6lowpan packet to handle somehow the
multicast stuff for L2 point-to-point connection.

I think it's described at [0], also there is somewhere some nicer
graphic.

So far I see it in the code, there is no such implementation to realize
multicasting on btle 6lowpan, or?

---

My questions are:

The neighbour cache stores the wrong addresses because the dev->addr isn't
the real bluetooth device addr and we need to use the l2 addr getting from
ndisc cache. Will this be fixed in the pending patch series?

As an example I can show you [1], which should be something like:

(I changed some variable names, just a byteswap)

dev->dev_addr[0] = bdaddr->b[5];
dev->dev_addr[1] = bdaddr->b[4];
dev->dev_addr[2] = bdaddr->b[3];
dev->dev_addr[3] = bdaddr->b[2];
dev->dev_addr[4] = bdaddr->b[1];
dev->dev_addr[5] = bdaddr->b[0];

The fffe, and bitflip for has nothing to do with that, this is necessary
for the /64 prefix in case of autoconfiguration [2], which should look
something like:

static int addrconf_ifid_eui64(u8 *eui, struct net_device *dev)
{
       switch (lowpan_dev(dev)->lltype) {
       case LOWPAN_LLTYPE_BTLE:
               if (dev->addr_len != 6)
                       return -1;

               memcpy(eui, dev->dev_addr, 3);
               memcpy(eui + 5, dev->dev_addr + 3, 3);
               eui[3] = 0xFF;
               eui[4] = 0xFE;

               /* Universal/local bit set, BT 6lowpan draft ch. 3.2.1 */
               if (*(dev->dev_addr + 5) & 0x02)
                       eui[0] |= 0x02;
               else
                       eui[0] &= ~0x02;
               break;
       default:
               if (dev->addr_len != EUI64_ADDR_LEN)
                       return -1;

               memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
               eui[0] ^= 2;
               break;
       }

       return 0;
}

Second question:

Still I don't know what exactly "some patches that make BTLE interfaces
non-point-to-point" really means here. Dropping the above mentioned flag
will not fix this behaviour. What does this really mean?

- Alex

[0] https://tools.ietf.org/html/rfc7668#section-3.2.5
[1] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L674
[2] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L1963
