Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt1-f171.google.com ([209.85.160.171]:35527 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVUb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Oct 2018 17:20:31 -0400
Received: by mail-qt1-f171.google.com with SMTP id v19-v6so6141228qtg.2
        for <linux-wpan@vger.kernel.org>; Wed, 03 Oct 2018 07:31:52 -0700 (PDT)
Date: Wed, 3 Oct 2018 10:31:46 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCHv2 wpan-tools] wpan-hwsim: hardware simulator
 configuration utility
Message-ID: <20181003143146.hf3qcdlxbvupt4yg@x220t>
References: <20180930215234.4679-1-aring@mojatatu.com>
 <d7ddf133-f8ff-e372-d722-14daa0de4545@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7ddf133-f8ff-e372-d722-14daa0de4545@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 03, 2018 at 10:14:09AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 30/09/2018 23:52, Alexander Aring wrote:
> > This patch adds initial support for wpan-hwsim utility to control the
> > mac802154_hwsim driver over netlink.
> > 
> > Signed-off-by: Alexander Aring <aring@mojatatu.com>
> > ---
> > 
> > Forgot if I ever send v2 but my local change has the last complain.
> > So I resend.
> > 
> > changes since v2:
> > - help and version both do not need an argument, please use no_argument
> > - printf("wpan-hwsim " PACKAGE_VERSION "\n");
> 
> Patch has been applied to wpan-tools. Thanks for fixing up my review
> comments.
> 
> Seems we want to get out a new wpan-tools release in the next weeks to
> have this utility available. I will see what I can do.
> 

wait please for a fix... I forgot that dot longarg needs no_argument as
well...

I begin to hate that interface. I need to define it for short with ':'
and then again for long in this struct. I do short sometimes only...
I will never do long args again, I fall into mistakes.

btw: I getting an expert to making python bindings... maybe I should
make a lib only in C and then all tools getting python based. :-) At
least for the next tool which I want to write.

- Alex
