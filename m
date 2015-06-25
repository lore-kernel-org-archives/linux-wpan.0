Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35016 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbFYRQB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 13:16:01 -0400
Received: by wgbhy7 with SMTP id hy7so68193041wgb.2
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 10:16:00 -0700 (PDT)
Date: Thu, 25 Jun 2015 19:15:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150625171557.GB3653@omega>
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 25, 2015 at 06:52:35PM +0200, Baptiste Clenet wrote:
> Hi,
> 
> Following is how I configure the network:
> modprobe at86rf230
> iwpan phy wpan-phy0 interface add wpan0 type node
> iwpan dev wpan0 set pan_id 0xbeef
> ip link set wpan0 up
> ip link add link wpan0 name lowpan0 type lowpan
> ip link set lowpan0 up
> 
> Then I try to ping6 my second board with:
> ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
> 
> I'm observing no changes over the SPI between my board and the
> at86rf230. But if I change the channel with:
> iwpan phy wpan-phy0 set channel 0 0

this change should not be possible with the at86rf230.

> I observe the changes over SPI.
> 

Do you have maybe the fakelb driver running? Please look for that, if
yes you have more than one phy. try "iwpan phy".

- Alex
