Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51509 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbaIDJBa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 05:01:30 -0400
Received: by mail-wg0-f42.google.com with SMTP id b13so9733619wgh.25
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 02:01:25 -0700 (PDT)
Received: from omega (p20030064A92EF5F3E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a92e:f5f3:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id hy9sm18674935wjb.27.2014.09.04.02.01.25
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2014 02:01:25 -0700 (PDT)
Date: Thu, 4 Sep 2014 11:01:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 1/6] nl_updates: initial commit of nl_updates
Message-ID: <20140904090119.GA18523@omega>
References: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
 <1409817834-14660-2-git-send-email-alex.aring@gmail.com>
 <20140904080609.GA13752@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140904080609.GA13752@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Thu, Sep 04, 2014 at 10:06:09AM +0200, Alexander Aring wrote:
> On Thu, Sep 04, 2014 at 10:03:49AM +0200, Alexander Aring wrote:
> > This patch adds a nl_updates header file to handle signed integer types
> > via netlink.
> > 
> > These types are support mainline at linux kernel but not supported by
> > current netlink library, this is a workaround to add these types.
> > 
> > It's protected by an ifdef, so it's safe when new netlink libraries will
> > add these functions.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  src/nl_updates.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 src/nl_updates.h
> > 
> > diff --git a/src/nl_updates.h b/src/nl_updates.h
> > new file mode 100644
> > index 0000000..066d5bb
> > --- /dev/null
> > +++ b/src/nl_updates.h
> > @@ -0,0 +1,75 @@
> > +/*
> > + *   lib/nl_updates.h - Updates to libnl which are not synced from kernel yet
> > + *   Copyright (C) 2012-2013 Jiri Pirko <jiri@resnulli.us>
> > + *
> > + *   This library is free software; you can redistribute it and/or
> > + *   modify it under the terms of the GNU Lesser General Public
> 
> oh, I can't use this code it's LGPL. Sorry. I will remove it now, grml.
> 

I will reimplement it to avoid any of license issues. What should I say
about it? It should be the same code like this one, I also will follow
the coding style of netlink and grab the necessary values from kernel
interface.

- Alex
