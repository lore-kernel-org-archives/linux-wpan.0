Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35176 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbEHQxW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 12:53:22 -0400
Received: by widdi4 with SMTP id di4so36779058wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 09:53:21 -0700 (PDT)
Date: Fri, 8 May 2015 18:53:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Error in including IEEE802154.h
Message-ID: <20150508165315.GC15416@omega>
References: <554B97A8.2040802@sssup.it>
 <20150508115030.GA15416@omega>
 <554CABCA.7080909@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <554CABCA.7080909@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, May 08, 2015 at 02:27:54PM +0200, Matteo Petracca wrote:
> Hi,
> the program that I am trying to compile is the test1.c
> in the lowpan-tools.
> 
> #include <linux/sockios.h>
> #include <net/if.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <stdio.h>
> #include <stdint.h>
> #include <string.h>
> #include <unistd.h>
> 
> #include "ieee802154.h"
> 

you know what this code does?

It search at first in the local dir where "test1.c" is stored for the
"ieee802154.h" header. Which means it's a local header.

A fallback behaviour of gcc will search this header in your given
include path which are given by -I and -stdinc gcc arguments.


What I can told you now that we don't deliver any headers into userspace
side with the kernel-headers. So this header comes from the lowpan-tools
package. Maybe tyoe a `find -name "ieee802154.h" $LOWPAN_TOOLS_DIR` in
your shell, to find it or whereever your include paths belongs to which
are given over "-I" of gcc call.

- Alex
