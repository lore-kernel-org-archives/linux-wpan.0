Return-Path: <SRS0=gm5i=BD=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A86C433E3
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Jul 2020 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCBD2065F
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Jul 2020 13:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXN1F (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:27:05 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:46068 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXN1F (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2020 09:27:05 -0400
Received: from localhost.localdomain (p200300e9d737162aa82ed0ab184b2e96.dip0.t-ipconnect.de [IPv6:2003:e9:d737:162a:a82e:d0ab:184b:2e96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 5EB98C234F;
        Fri, 24 Jul 2020 15:27:00 +0200 (CEST)
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
 <8ddb855b-e9fb-6fb2-cb1f-38a7b7064683@datenfreihafen.org>
 <3993a752-bb9c-ab25-7b2f-0cbf27c2cd6a@datenfreihafen.org>
 <CAF4BF-TdLpg6hCc8iiR40tGmV9C5EPDF6c6Qr5m5CfDWOVJUMA@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <58d03eed-00e3-7c96-3464-4b30719ca90c@datenfreihafen.org>
Date:   Fri, 24 Jul 2020 15:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-TdLpg6hCc8iiR40tGmV9C5EPDF6c6Qr5m5CfDWOVJUMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello

On 21.07.20 19:11, Christopher Friedt wrote:
> 
> Does Linux already support the 900 MHz phy and IEEE bits?
> 
> If possible, we're hoping to be able to use it for the 2.4 GHz band and 
> the 900 MHz band.

As follow up from what I wrote on the 900 MHz stuff before here is a 
link where we are adding sub GHz support to the atusb driver

https://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git/commit/?id=d5dd29e4dafef4baad7bf529ad73cafeb13e1aa8

regards
Stefan Schmidt
