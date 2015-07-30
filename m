Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55201 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbbG3TcG (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jul 2015 15:32:06 -0400
Subject: Re: [RFC bluetooth-next 0/2] 6lowpan: introduce generic 6lowpan
 private data
References: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55BA7BAF.50404@osg.samsung.com>
Date: Thu, 30 Jul 2015 21:31:59 +0200
MIME-Version: 1.0
In-Reply-To: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no

Hello.

On 29/07/15 14:24, Alexander Aring wrote:
> Hi,
>
> I already thought many times to introduce something like that. Here is a draft
> for introducing the generic 6lowpan private data into each lowpan interface.
> For the beginning I introduced the enum "l2_type" which contains the L2 type of
> a lowpan interface.
>
> Use cases for such feature (L2 types):
>
>   - If we do in upper layers (6LoWPAN/IPv6) a evaluation of dev->type then
>     the value is on all lowpan interfaces "APRHRD_6LOWPAN". If we checked on
>     "dev->type" and it's ARPHRD_6LOWPAN we can safe use lowpan_priv to get
>     6LoWPAN generic private data. With this data we can check the L2 type which
>     can be currently BTLE or IEEE802154. This could be useful to make different
>     handling in iphc compress/decompress and evaluating L2 private data of skb
>     control block "skb->cb".

And there is more to come. Power line, low power wifi, dect, etc. For 
all of them some 6lowpan adaptiona re on the way. Which of them really 
makes it to a full RFC is to be seen but having a L2 type here is a good 
idea.

>
>     Example (802.15.4 has different address handling functionality):
>
>     switch (lowpan_priv(dev)->l2_type) {
>     case LOWPAN_L2_TYPE_BTLE:
>          /* do EUI64 btle handling */
>          break;
>     case LOWPAN_L2_TYPE_IEEE802154:
>          /* do complicated short/extended address handling */
> 	/* we can surely call skb->cb to some other private data from L2
>             which was set before iphc compress/decompress function call */
> 	break;
>     }
>
>     The handling is currently for 802.15.4 is in generic 6lowpan code currently
>     not quite. This should be handled by private data. At the moment btle use
>     the same handling like for 802.15.4 extended address. Nevertheless is we can
>     cleanup some handling then in generic iphc functionality.
>
>     This also possible in layers like IPv6, just doing a check on APRHRD_6LOWPAN
>     before calling lowpan_priv(dev)->l2_type, then we are sure that the private
>     data of the interface is a 6LoWPAN interface and we can cast it to lowpan_priv.
>     Then we can do 6LoWPAN generic stuff OR 6lowpan specific L2 stuff.
>
>   - In Lukasz Duda RFC for introducing stateful address compression, I saw
>     some behaviour which such functionality is also useful. Currently we don't
>     have a allocated space for a 6LoWPAN generic space which is assigned to a
>     lowpan interface. When L2 layers (BTLE, IEEE802154) calls iphc
>     compress/decompress Lukasz had no change to access some room which is needed
>     for storing the context information into a table. The workaround for this
>     feature was to add allocate a static data room for the table and doing a
>     lookup/match of netdev name. Which a generic 6lowpan private data room per each
>     lowpan interface we can put this table according to the netdev private room,
>     which means in short: no lookup is needed anymore, just dereferencing lowpan_priv.
>
>     In upper layer like IPv6 Lukasz could use that to get the stateful context
>     table information as an example for doing 6LoWPAN generic stuff in upper
>     layers.

I in favor for having this. Will review the implementation in a moment.

regards
Stefan Schmidt
