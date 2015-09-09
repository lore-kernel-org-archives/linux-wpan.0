Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38319 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbIINN0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 09:13:26 -0400
Received: by wiclk2 with SMTP id lk2so21368503wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 09 Sep 2015 06:13:25 -0700 (PDT)
Date: Wed, 9 Sep 2015 15:13:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: At86rf230 sleep state
Message-ID: <20150909131315.GA13947@omega>
References: <CAPpUg6MbD04CcGAkOfs=NB4hS_3nqt-v38edwsXCd1sF-_3R1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6MbD04CcGAkOfs=NB4hS_3nqt-v38edwsXCd1sF-_3R1w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Sep 09, 2015 at 02:26:27PM +0200, Baptiste Clenet wrote:
> Hi,
> 
> I looked at the at86rf230 driver on bluetooth-next branch and I saw the
> two functions concerning the sleep state:
> 
> at86rf230_sleep(struct at86rf230_local *lp)
> 
> at86rf230_awake(struct at86rf230_local *lp)
> 
> 
> I'm wondering if the transceiver can wake up from a received frame if
> it is in SLEEP State? As far as I can see on the datasheet, it is not
> able to. Am I wrong?
> 

The transceiver can't. The transceiver need to be inside RX_AACK_ON state
(or RX_ON, but we don't use this state).

What we currently support for powersaving is when the subsystem doesn't
use the transceiver then the transceiver goes into SLEEP state.

This happens when:

 1. After device probing.
 2. When _ALL_ interfaces which belongs to the transceiver (phy) are
    down. -> Which is the state after probing. See 1.
 3. When interfaces are up and you going into pm-suspend mode. (The
    interfaces are still up, but the transceiver will call "stop"
    callback before and this is the same like 2. -> It stops rx but when
    stopping rx you can also go into sleep). When "resume" occurs the
    subsystem call "start" callback and do a "awake" and acivate rx again.

Addtional note: we need to awake the transceiver to access registers,
there exists "direct or non-direct" nl802154 calls into the driver layer
to set registers. This is why we add before and after register access an
awake and sleep again. -> but this is very transceiver specifc, there
exists also transceiver which has register access while sleeping.


This is currently the stuff we support for powersaving, this has nothing
todo with 802.15.4 powersaving stuff like "beacon enabled mode". We
currently doesn't support this kind of stuff and I have also no idea how
it works and how we can implement this stuff for SoftMAC transceivers.
:-)

- Alex
