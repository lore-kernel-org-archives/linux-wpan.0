Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36265 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEHLul (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 07:50:41 -0400
Received: by wgiu9 with SMTP id u9so70123216wgi.3
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 04:50:40 -0700 (PDT)
Date: Fri, 8 May 2015 13:50:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Error in including IEEE802154.h
Message-ID: <20150508115030.GA15416@omega>
References: <554B97A8.2040802@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <554B97A8.2040802@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, May 07, 2015 at 06:49:44PM +0200, Matteo Petracca wrote:
> Dear all,
> I gave a program in kernel 3.8.17 in which I successfully include
> ieee802154.h by simply witing:
> 
> #include <ieee802154.h>
> 
> In my BeagleBone now I have just upgraded the kernel to 4.0.1,
> and compiling the same code I get:
> 
> fatal error: ieee802154.h: No such file or directory
> 
> Any hint?
> 

no, I suppose that this header is some of the old netlink interface, but
I can't be sure here. I can't be sure because I don't know what was the
functionality/why you need  that in your application.


In short:

We don't deliever any headers to uapi for userspace. If you need headers
for userspace<->kernelspace communication you need to grab them on your
own out of your current kernel source tree. What I mean is that we
didn't change any in our uapi headers which are deliviered by
kernel-headers because we don't have any headers which laying inside
"include/uapi" tree right now.

- Alex
