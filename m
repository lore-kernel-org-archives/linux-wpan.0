Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33101 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbbFCOrD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 10:47:03 -0400
Received: by wgez8 with SMTP id z8so11328339wge.0
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 07:47:02 -0700 (PDT)
Date: Wed, 3 Jun 2015 16:46:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: error: nl802154 not found
Message-ID: <20150603144657.GB744@omega>
References: <CAPpUg6Oj5TbS9qwdor-uymsU5bzhUMxJXk=RBd+1UmPXwHVK=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6Oj5TbS9qwdor-uymsU5bzhUMxJXk=RBd+1UmPXwHVK=Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 03, 2015 at 03:08:44PM +0200, Baptiste Clenet wrote:
> Hi,
> 
> I finally managed to set up the at86rf212B with some edits in spi
> driver and pinctrl driver.
> 
> Anyway, I've got an at86rf212B set up now and I wanted to use iwpan tools.
> As soon as I use "iwpan list", I get an error: "nl802154 not found"
> 
> 
> The at86rf230 driver seems to register an ieee802154 device without
> errors: ieee802154_register_device(lp->dev);
> 
> What could be the problem?
> 

which kernel version do you use?

- Alex
