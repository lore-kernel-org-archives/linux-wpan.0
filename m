Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36722 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbbFCPIu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 11:08:50 -0400
Received: by laei3 with SMTP id i3so10518872lae.3
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 08:08:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150603144657.GB744@omega>
References: <CAPpUg6Oj5TbS9qwdor-uymsU5bzhUMxJXk=RBd+1UmPXwHVK=Q@mail.gmail.com>
	<20150603144657.GB744@omega>
Date: Wed, 3 Jun 2015 17:08:44 +0200
Message-ID: <CAPpUg6Mpz+tPKeFBc6zyXo1e3O0SbQiQOWBPFNnd3cX42qS6Pw@mail.gmail.com>
Subject: Re: error: nl802154 not found
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Linux 3.18.14

Is that a problem?

Baptiste

2015-06-03 16:46 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Wed, Jun 03, 2015 at 03:08:44PM +0200, Baptiste Clenet wrote:
>> Hi,
>>
>> I finally managed to set up the at86rf212B with some edits in spi
>> driver and pinctrl driver.
>>
>> Anyway, I've got an at86rf212B set up now and I wanted to use iwpan tools.
>> As soon as I use "iwpan list", I get an error: "nl802154 not found"
>>
>>
>> The at86rf230 driver seems to register an ieee802154 device without
>> errors: ieee802154_register_device(lp->dev);
>>
>> What could be the problem?
>>
>
> which kernel version do you use?
>
> - Alex
