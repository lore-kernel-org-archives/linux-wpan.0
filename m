Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45573 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932976AbeFLNWr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Jun 2018 09:22:47 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so27965466ioh.12
        for <linux-wpan@vger.kernel.org>; Tue, 12 Jun 2018 06:22:46 -0700 (PDT)
Date: Tue, 12 Jun 2018 09:22:36 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: netdevice notifier and device private data
Message-ID: <20180612132236.wld4mh6ecwcopmfl@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
 <32763.1528486664@localhost>
 <20180609152921.hqfmprmd4ryttaie@x220t>
 <29706.1528570878@localhost>
 <20180610153956.mgzigzfne6shjb4s@x220t>
 <1326.1528682979@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1326.1528682979@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr+ietf@sandelman.ca>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Sun, Jun 10, 2018 at 10:09:39PM -0400, Michael Richardson wrote:
> 
> Alexander Aring <aring@mojatatu.com> wrote:
>     >> It totally seems like broken behaviour.  Maybe it's not even
>     >> intentional.  Maybe they are just foobar.
> 
>     > They simple don't know what they doing... somebody thought 6LoWPAN need
>     > to be 6LoWPAN, but they actually don't use the 6LoWPAN handling inside
>     > the kernel. _Except_ they doing out of tree stuff which I don't
>     > believe.
> 
> So, it seems like this ioctl() should be disabled, or restricted to cases
> that actually work.  hate to break their code, but if it's broken anyway, at
> least the kernel won't crash under them.
> 

before we breaking their software I will gentle ask before why they
doing that and I get a good reason then. Then we look more how we deal
with an illegal read/dereference in dev->priv.

I will figure out how I can do that over github.

- Alex
