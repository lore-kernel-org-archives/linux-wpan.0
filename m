Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:55169 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966399AbaLLOUS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:20:18 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so9278646wgh.27
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 06:20:16 -0800 (PST)
Date: Fri, 12 Dec 2014 15:20:13 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: inital commit
Message-ID: <20141212142011.GB381@omega>
References: <1418392049-11101-1-git-send-email-alex.aring@gmail.com>
 <1418392049-11101-2-git-send-email-alex.aring@gmail.com>
 <24c101d01614$5df70090$19e501b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24c101d01614$5df70090$19e501b0$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Dec 12, 2014 at 02:03:11PM +0000, Stefan Schmidt wrote:
> Hello.
> 
> Good to see this getting a bit more documented. Some remarks inline.
> 
> On 12/12/14 14:47, Alexander Aring wrote:
> >This is the initial commit for the website asciidoc framework of:
> >
> >http://wpan.cakelab.org/
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  website/.gitingore |   1 +
> >  website/Makefile   |   5 +++
> >  website/index.txt  | 128
> >+++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 134 insertions(+)
> >  create mode 100644 website/.gitingore
> >  create mode 100644 website/Makefile
> >  create mode 100644 website/index.txt
> >
> >diff --git a/website/.gitingore b/website/.gitingore
> >new file mode 100644
> >index 0000000..dcaf716
> >--- /dev/null
> >+++ b/website/.gitingore
> >@@ -0,0 +1 @@
> >+index.html
> >diff --git a/website/Makefile b/website/Makefile
> >new file mode 100644
> >index 0000000..cc090bc
> >--- /dev/null
> >+++ b/website/Makefile
> >@@ -0,0 +1,5 @@
> >+all:
> >+	asciidoc -b html5 -a icons -a toc2 -a theme=flask index.txt
> >+
> >+clean:
> >+	rm index.html
> >diff --git a/website/index.txt b/website/index.txt
> >new file mode 100644
> >index 0000000..a7ab4bb
> >--- /dev/null
> >+++ b/website/index.txt
> >@@ -0,0 +1,128 @@
> >+linux-wpan
> >+==========
> >+Mailinglist <linux-wpan@vger.kernel.org>
> >+
> >+wpan-tools
> >+----------
> >+
> >+To access the nl802154 netlink inteface you will need the wpan-tools.
> >+
> >+Dependencies:
> >+
> >+- netlink library http://www.infradead.org/~tgr/libnl/[libnl].
> 
> Better name it libnl-3 here as it does not work with libnl-1 and libnl-2
> 

ok. I thought also about that.

The original iw tool has backwards compat. to older libnl version. We
could fix that inside the wpan-tools. But for now indeed libnl-3 is
supported only. I will change to it and maybe we have also this
backwards compat like iw.

> >+These tools contains:
> >+
> >+[horizontal]
> >+*iwpan*:: based on the wireless
> >http://wireless.kernel.org/en/users/Documentation/iw[iw] tool.
> >+
> >+Download
> >+~~~~~~~~
> >+For the last release check out
> >http://wpan.cakelab.org/releases/[releases] page:
> >+
> >+http://wpan.cakelab.org/releases/
> >+
> >+Supported Hardware
> >+------------------
> >+
> >+.Supported 802.15.4 Hardware
> >+[cols="3,4,2,^2,12",options="header"]
> >+|=============================================================
> >+|Transceiver |Supported        |Driver     | Bus |Where to buy
> >+|at86rf230   |no               |at86rf230? | SPI |
> >+|at86rf231   |yes              |at86rf230  | SPI |
> >http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of
> >stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact
> >http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> >+|at86rf233   |yes              |at86rf230  | SPI |
> >http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
> >+|at86rf212   |yes              |at86rf230  | SPI |
> >+|atusb       |not mainline yet |atusb      | USB |
> >http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of
> >stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact
> >http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> >+|=============================================================
> 
> Maybe mention the other drivers we have mainline here as well? CC2520 and
> MRF24j40 are fully supported or not?

Don't know about these transceivers I have CC2520 here but these are
buildin inside some contiki nodes and I don't have any pinout headers
for these.

Specially MRF24j40 have some different types and I don't know which type
is now supported. The driver maintainers can send patches to linux-wpan
and I will apply changes to wpan-misc and generate a new website.

For futher maybe we should add some "features" collumn because many of
them doesn't support all driver callbacks.

> 
> As a sidenote I build and updated the firmware for my atusb and did some
> initial testing. Nothing on the RF side yet as I wait for more hardware to
> test against. I'm willing to bring this driver mainline and update it as
> needed. So far I only made sure that atusb and at86rf230 share the same
> header file for register defines to avoid duplication.

ok.

> 
> Once I have other hardware I will test the RF side of things and start to
> work on asnyc xmit. Also need to talk to Werner if he is happy with the fw
> interface. After that I will send out a RFC for it.
> 

ok.

- Alex
