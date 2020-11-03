Return-Path: <SRS0=uuEQ=EJ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38665C2D0A3
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B3C20735
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKCQrK (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:47:10 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:43830 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCQrK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Nov 2020 11:47:10 -0500
Received: from localhost.localdomain (p200300e9d729b09a69789643056dba7d.dip0.t-ipconnect.de [IPv6:2003:e9:d729:b09a:6978:9643:56d:ba7d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 9412FC0A8C;
        Tue,  3 Nov 2020 17:47:08 +0100 (CET)
Subject: Re: wpanusb?
To:     Christopher Friedt <chrisfriedt@gmail.com>
Cc:     Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        erik@statropy.com
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
 <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
 <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
 <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
 <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org>
 <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
 <6d787a84-56ba-2dcf-af5c-6f05cec6194a@datenfreihafen.org>
 <71f4ce0f-5614-6410-9c8b-72a87ab7473d@datenfreihafen.org>
 <CAF4BF-TG4wpX8TdEXY=EeTz4HV0b-nceFwKb=VkFBkMjfSLPew@mail.gmail.com>
 <e75f3fd8-fa0c-7708-e914-f757965920c0@datenfreihafen.org>
 <CAF4BF-TYYF_FU7dKFR+VXfYKFUfWes4euLPY3UMOL_f62_4hAQ@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <cf50d083-e9d4-c92f-8033-aaf763c0d6a1@datenfreihafen.org>
Date:   Tue, 3 Nov 2020 17:47:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-TYYF_FU7dKFR+VXfYKFUfWes4euLPY3UMOL_f62_4hAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

Sorry for the delay. I tagged the mail but still forgot about it. :(

On 15.10.20 22:16, Christopher Friedt wrote:
> On Sun, Sep 27, 2020 at 4:59 AM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
>>> Also, somewhat annoying, but a shoddy USB hub damaged my ATUSB :( I
>>> ordered 2 more, so hopefully they get to me shortly!
> 
> I received my 2 ATUSB :-)
> 

Yay :-)

> Here is a question though - the cc1352r supports 802.15.4g (GFSK /
> 2-FSK / 4-FSK / OQPSK) and does not support BPSK for 868 MHz or 915
> Mhz.
> 
> Erik confirmed today that our wpanusb solution is working today both
> at 2.4 GHz and SubGHz, but we are using channels 0-11 for SubGHz. I
> think those are reserved for the BPSK phy though.
> 
> Do we have pages / channels that cover the 802.15.4g PHYs in the wpan
> stack? Are there any suggestions for which page / channels to use? We
> have been looking through the spec, but of course it's quite dense
> nowadays.

Hmm, I would need to check the spec as well. ieee802154 and mac802154 
should not really limit the used pages or channels. We have no regulator 
daemon or such in place (me might should though). IIRC we simply let the 
driver define its channel table.

> Also, since these radios can theoretically work simultaneously, we are
> considering exposing that as two separate and simultaneous PHYs and
> data paths. Is that something that would be desirable in wpanusb?

Yes, if these could work simultaneously we should allow to expose both 
phy's. Exposing two USB devices from the firmware and let the kernel 
have two wpanusb instances using them would what I first off.

regards
Stefan Schmidt
