Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34511 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbFYRag (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 13:30:36 -0400
Received: by wicnd19 with SMTP id nd19so24443989wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 10:30:35 -0700 (PDT)
Date: Thu, 25 Jun 2015 19:30:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150625173032.GC3653@omega>
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
 <20150625171557.GB3653@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150625171557.GB3653@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 25, 2015 at 07:15:57PM +0200, Alexander Aring wrote:
> On Thu, Jun 25, 2015 at 06:52:35PM +0200, Baptiste Clenet wrote:
> > Hi,
> > 
> > Following is how I configure the network:
> > modprobe at86rf230
> > iwpan phy wpan-phy0 interface add wpan0 type node
> > iwpan dev wpan0 set pan_id 0xbeef
> > ip link set wpan0 up
> > ip link add link wpan0 name lowpan0 type lowpan
> > ip link set lowpan0 up
> > 
> > Then I try to ping6 my second board with:
> > ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
> > 
> > I'm observing no changes over the SPI between my board and the
> > at86rf230. But if I change the channel with:
> > iwpan phy wpan-phy0 set channel 0 0
> 
> this change should not be possible with the at86rf230.
> 

ah, with the at86rf212 it's possible to set page/channel to 0. But I
have still no idea why you having this issues right now.

Everything which you did seems to be correct. Which kernel version do
you use and why you do a:

iwpan phy wpan-phy0 interface add wpan0 type node

there should be a wpan0 node interface by default.

- Alex
