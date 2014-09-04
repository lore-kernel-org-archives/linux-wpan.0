Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:65262 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbaIDIG3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 04:06:29 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so9788006wev.20
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 01:06:26 -0700 (PDT)
Received: from omega (p20030064A92EF5F3E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a92e:f5f3:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id ju1sm18597669wjc.1.2014.09.04.01.06.25
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2014 01:06:25 -0700 (PDT)
Date: Thu, 4 Sep 2014 10:06:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 1/6] nl_updates: initial commit of nl_updates
Message-ID: <20140904080609.GA13752@omega>
References: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
 <1409817834-14660-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1409817834-14660-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Thu, Sep 04, 2014 at 10:03:49AM +0200, Alexander Aring wrote:
> This patch adds a nl_updates header file to handle signed integer types
> via netlink.
> 
> These types are support mainline at linux kernel but not supported by
> current netlink library, this is a workaround to add these types.
> 
> It's protected by an ifdef, so it's safe when new netlink libraries will
> add these functions.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  src/nl_updates.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 src/nl_updates.h
> 
> diff --git a/src/nl_updates.h b/src/nl_updates.h
> new file mode 100644
> index 0000000..066d5bb
> --- /dev/null
> +++ b/src/nl_updates.h
> @@ -0,0 +1,75 @@
> +/*
> + *   lib/nl_updates.h - Updates to libnl which are not synced from kernel yet
> + *   Copyright (C) 2012-2013 Jiri Pirko <jiri@resnulli.us>
> + *
> + *   This library is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU Lesser General Public

oh, I can't use this code it's LGPL. Sorry. I will remove it now, grml.

- Alex
