Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:40016 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbaIWIGR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 04:06:17 -0400
Received: by mail-wi0-f180.google.com with SMTP id q5so4476186wiv.13
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 01:06:15 -0700 (PDT)
Date: Tue, 23 Sep 2014 10:06:12 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
Message-ID: <20140923080610.GB11396@omega>
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
 <20140916070156.GB1244@omega>
 <541899D8.4020101@componentsw.com>
 <20140916202000.GF6104@omega>
 <5420EE4F.5000007@signal11.us>
 <20140923071932.GA11396@omega>
 <5421280E.2060203@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5421280E.2060203@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Alan Ott <alan@signal11.us>, Walter Mack <wmack@componentsw.com>, linux-wpan@vger.kernel.org

On Tue, Sep 23, 2014 at 08:58:06AM +0100, Simon Vincent wrote:
> I was under the impression the patch had been signed off. Maybe I missed a
> mail...

mhh, I didn't see any signed-off or acked-by from alan. Maybe just cc
linux-wpan or me there.

> I can confirm the mrf24j40 works just fine using a DT.
> 

Yes basically this works, because dt have some out of the box feature to
load devices at boottime by modulename.

Normally you have some compatible names for your device like:

static const struct of_device_id at86rf230_of_match[] = {
        { .compatible = "atmel,at86rf230", },
        { .compatible = "atmel,at86rf231", },
        { .compatible = "atmel,at86rf233", },
        { .compatible = "atmel,at86rf212", },
        { },
};
MODULE_DEVICE_TABLE(of, at86rf230_of_match);

the mrf24j40 works for dt and has no platform data or something else.
But it's different than make the driver dt-enabled. It's only working
because DT allows to load modules by modulenames.

- Alex
