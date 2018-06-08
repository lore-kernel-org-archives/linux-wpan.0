Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:46134 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeFHTlG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Jun 2018 15:41:06 -0400
Received: by mail-io0-f179.google.com with SMTP id d22-v6so17149973iof.13
        for <linux-wpan@vger.kernel.org>; Fri, 08 Jun 2018 12:41:06 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:41:00 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: netdevice notifier and device private data
Message-ID: <20180608194100.p5jtgook4bp4dkyw@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
 <20180608111457.0a9b4cae@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608111457.0a9b4cae@xeon-e3>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi Stephen,

On Fri, Jun 08, 2018 at 11:14:57AM -0700, Stephen Hemminger wrote:
...
> 
> notifiers are always called with RTNL mutex held
> and dev->type should not change unless RTNL is held.

thanks for you answer. I am not talking about any race between notifiers
vs dev->type change.

I am talking that dev->type was already changed and a upcoming notifier ends
in undefined behaviour when it derefences dev->priv. I have some notifier
which maps a cast from dev->type to a specific structure at dev->priv. This
structure is not there in tap/tun devices if they changed to "my" dev->type
and the notifier occurs.

- Alex
