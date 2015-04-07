Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37205 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbDGUMk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 16:12:40 -0400
Received: by wiaa2 with SMTP id a2so32892110wia.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 13:12:39 -0700 (PDT)
Date: Tue, 7 Apr 2015 22:12:36 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: hardware recommendation
Message-ID: <20150407201233.GH16415@omega>
References: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
 <20150323075818.GA4069@omega>
 <4E57CCC9-A879-457C-9471-9A83BA417CE5@cisco.com>
 <CAFUtXGzGeMmbSNtbP2xdjr6uitzFwPZCb3Yo-GV2+2gV3uz6+w@mail.gmail.com>
 <978F3708-BC58-46E5-AED3-3C4CE1C4BBD3@cisco.com>
 <CAFUtXGzHpvDcCErKfyGTvGYri-PsmToNUE7rvoniLmqmdZ8q6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUtXGzHpvDcCErKfyGTvGYri-PsmToNUE7rvoniLmqmdZ8q6w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: "Ralph Droms (rdroms)" <rdroms@cisco.com>, linux-wpan@vger.kernel.org

Hi Maciej,

On Tue, Apr 07, 2015 at 09:19:59PM +0200, Maciej Wasilak wrote:
> Ralph,
> 
> I followed tutorial at [1]. Tip to enable DWC is at [2]
> 
> I attached my current .config (I don't know if mailing list tolerates
> attachments). I am using Raspbian as my base system, I have
> RaspberryPi B (oldest one).

I try with your config and still no luck with RPi and ethernet. I
suppose this is because the u-boot bootloader do some magic. I don't use
u-boot and then I have not the init routines for usb like you. Seems
like this is some missing feature in RPi USB handling, I don't know...
I don't want to try now to boot with u-boot, but I guess it's because
u-boot to some magic there...

- Alex
