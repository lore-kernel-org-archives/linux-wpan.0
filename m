Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35515 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbGaH27 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 31 Jul 2015 03:28:59 -0400
Date: Fri, 31 Jul 2015 09:29:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 0/2] 6lowpan: introduce generic 6lowpan
 private data
Message-ID: <20150731072908.GA1125@omega>
References: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
 <55BA7BAF.50404@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55BA7BAF.50404@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no

On Thu, Jul 30, 2015 at 09:31:59PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 29/07/15 14:24, Alexander Aring wrote:
> >Hi,
> >
> >I already thought many times to introduce something like that. Here is a draft
> >for introducing the generic 6lowpan private data into each lowpan interface.
> >For the beginning I introduced the enum "l2_type" which contains the L2 type of
> >a lowpan interface.
> >
> >Use cases for such feature (L2 types):
> >
> >  - If we do in upper layers (6LoWPAN/IPv6) a evaluation of dev->type then
> >    the value is on all lowpan interfaces "APRHRD_6LOWPAN". If we checked on
> >    "dev->type" and it's ARPHRD_6LOWPAN we can safe use lowpan_priv to get
> >    6LoWPAN generic private data. With this data we can check the L2 type which
> >    can be currently BTLE or IEEE802154. This could be useful to make different
> >    handling in iphc compress/decompress and evaluating L2 private data of skb
> >    control block "skb->cb".
> 
> And there is more to come. Power line, low power wifi, dect, etc. For all of
> them some 6lowpan adaptiona re on the way. Which of them really makes it to
> a full RFC is to be seen but having a L2 type here is a good idea.

In short the use case would be "casting private data corretly":

We have currently the situation that lowpan interfaces uses
ARPHRD_6LOWPAN which is correct for me.

Usually to get the netdev_priv in generic upper layers is:

switch (dev->type) {
case ARPHRD_6LOWPAN:
	my_private_data_struct = netdev_priv(dev);
	/* do great stuff which is ARPHRD_6LOWPAN related */
	break;
case ARPHRD_FOOBAR:
	my_private_data_struct = netdev_priv(dev);
	/* do great stuff which is ARPHRD_FOOBAR related */
	break;
case ...
	...
	break;
}

with the lowpan_priv struct we have a private data room for 6LoWPAN
generic layer which is allocated per interface (We don't have the option
to make such behaviour above because currently each lowpan interface do
their own link layer stuff in netdev_priv and their share the same
ARPHRD).

What we introduce now is a 6LoWPAN generic + linklayer private data room.

In case of generic 6LoWPAN handling we can do now:

switch (dev->type) {
case ARPHRD_6LOWPAN:
	lowpan_data_struct = lowpan_priv(dev);
	/* do great stuff which is ARPHRD_6LOWPAN related */
	break;
...
}

In case of special linklayer handling (e.g. address handling in
802.15.4) we can do the following now:

switch (dev->type) {
case ARPHRD_6LOWPAN:
	lowpan_data_struct = lowpan_priv(dev);
	/* do great stuff which is ARPHRD_6LOWPAN related */
	switch (lowpan_data_struct->ll_type)
	case LOWPAN_LL_TYPE_IEEE802154:
		lowpan_802154_data struct = (great cast *)lowpan_priv(dev)->priv;
		/* do 802.15.4 6LoWPAN handling here */
		break;
	....
	}
	break;
...
}


So we have actually the same mechanism like "switch (dev->type)" ->
"casting private data" for "switch (lowpan_priv(dev)->ll_type)" ->
"casting 6LoWPAN LL private data".

In my opinion we definitely need such behaviour and some "net/6lowpan"
code parts looks already weird because we don't have such mechanism.

It's just some struct hierarchy where we introduce now a private data
for the ARPHRD_6LOWPAN type.

- Alex
