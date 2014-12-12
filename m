Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:17753 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967651AbaLLODa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:03:30 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGH00GIG38KHL00@mailout3.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Fri, 12 Dec 2014 14:07:32 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418392049-11101-1-git-send-email-alex.aring@gmail.com>
 <1418392049-11101-2-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418392049-11101-2-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: inital commit
Date: Fri, 12 Dec 2014 14:03:11 +0000
Message-id: <24c101d01614$5df70090$19e501b0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

Good to see this getting a bit more documented. Some remarks inline.

On 12/12/14 14:47, Alexander Aring wrote:
> This is the initial commit for the website asciidoc framework of:
>
> http://wpan.cakelab.org/
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   website/.gitingore |   1 +
>   website/Makefile   |   5 +++
>   website/index.txt  | 128
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 website/.gitingore
>   create mode 100644 website/Makefile
>   create mode 100644 website/index.txt
>
> diff --git a/website/.gitingore b/website/.gitingore
> new file mode 100644
> index 0000000..dcaf716
> --- /dev/null
> +++ b/website/.gitingore
> @@ -0,0 +1 @@
> +index.html
> diff --git a/website/Makefile b/website/Makefile
> new file mode 100644
> index 0000000..cc090bc
> --- /dev/null
> +++ b/website/Makefile
> @@ -0,0 +1,5 @@
> +all:
> +	asciidoc -b html5 -a icons -a toc2 -a theme=flask index.txt
> +
> +clean:
> +	rm index.html
> diff --git a/website/index.txt b/website/index.txt
> new file mode 100644
> index 0000000..a7ab4bb
> --- /dev/null
> +++ b/website/index.txt
> @@ -0,0 +1,128 @@
> +linux-wpan
> +==========
> +Mailinglist <linux-wpan@vger.kernel.org>
> +
> +wpan-tools
> +----------
> +
> +To access the nl802154 netlink inteface you will need the wpan-tools.
> +
> +Dependencies:
> +
> +- netlink library http://www.infradead.org/~tgr/libnl/[libnl].

Better name it libnl-3 here as it does not work with libnl-1 and libnl-2

> +These tools contains:
> +
> +[horizontal]
> +*iwpan*:: based on the wireless
> http://wireless.kernel.org/en/users/Documentation/iw[iw] tool.
> +
> +Download
> +~~~~~~~~
> +For the last release check out
> http://wpan.cakelab.org/releases/[releases] page:
> +
> +http://wpan.cakelab.org/releases/
> +
> +Supported Hardware
> +------------------
> +
> +.Supported 802.15.4 Hardware
> +[cols="3,4,2,^2,12",options="header"]
> +|=============================================================
> +|Transceiver |Supported        |Driver     | Bus |Where to buy
> +|at86rf230   |no               |at86rf230? | SPI |
> +|at86rf231   |yes              |at86rf230  | SPI |
> http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of
> stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact
> http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> +|at86rf233   |yes              |at86rf230  | SPI |
> http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
> +|at86rf212   |yes              |at86rf230  | SPI |
> +|atusb       |not mainline yet |atusb      | USB |
> http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of
> stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact
> http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> +|=============================================================

Maybe mention the other drivers we have mainline here as well? CC2520 
and MRF24j40 are fully supported or not?

As a sidenote I build and updated the firmware for my atusb and did some 
initial testing. Nothing on the RF side yet as I wait for more hardware 
to test against. I'm willing to bring this driver mainline and update it 
as needed. So far I only made sure that atusb and at86rf230 share the 
same header file for register defines to avoid duplication.

Once I have other hardware I will test the RF side of things and start 
to work on asnyc xmit. Also need to talk to Werner if he is happy with 
the fw interface. After that I will send out a RFC for it.

regards
Stefan Schmidt


