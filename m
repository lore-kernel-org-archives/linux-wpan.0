Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63648 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaLEOcD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 09:32:03 -0500
Date: Fri, 5 Dec 2014 15:31:58 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan next header compression framwork: module handling or not?
Message-ID: <20141205143156.GC478@omega>
References: <20141205124602.GB478@omega>
 <1417786926.32209.9.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1417786926.32209.9.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, linux-wpan@vger.kernel.org, martin.townsend@xsilon.com

Hi Jukka,

On Fri, Dec 05, 2014 at 03:42:06PM +0200, Jukka Rissanen wrote:
...
> I am fine if the "default" being a module, as long as it is
> automatically loaded. From the end user point of view, he/she should not
> configure or do any magic in order to use 6lowpan.
> 

Seems that I am not a module linux guru. I don't know how I can
implement such feature. The nhc compression module depends on 6lowpan.ko
module but 6lowpan.ko can't depend on the nhc compression modules. If
there would be some dependency then 6lowpan.ko would load the
compression modules at module_init. Means some symbols are missing and
"something" try to load the right modules to get these symbols.

I tried to create such behaviour but failed. I don't know if this is
really possible or I don't know how I can implement this behaviour.

What I tried was to implement a "dummy" function, which seems to be also
a hack in my opnion. This "dummy" function was implemented in the nhc module.

void lowpan_nhc_rfc6282_udp_load(void) { }
EXPORT_SYMBOL(lowpan_nhc_rfc6282_udp_load);

Then lowpan_nhc_rfc6282_udp_load was called at module_init of 6lowpan.ko
but I got some linking issues.


Maybe I need some time to getting the idea how I can implement such
behaviour without ugly hacks. Currently I don't know how I can implement
something like that. Maybe the solution is easy.

- Alex
