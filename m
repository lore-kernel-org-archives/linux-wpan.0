Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58643
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753332AbcKYKAp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 25 Nov 2016 05:00:45 -0500
Subject: Re: [PATCH wpan-tools 0/8] Various example for 802.15.4 and 6LoWPAN
 socket usage
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <d9a84ab2-49ce-7946-ca72-c25514b5adb7@osg.samsung.com>
Date: Fri, 25 Nov 2016 11:00:19 +0100
MIME-Version: 1.0
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

Hello.

On 21/11/16 21:34, Stefan Schmidt wrote:
> Hello.
>
> Needed for a long time, we have here a set of example demonstrating three types
> of socket usage example for the Linux-wpan stack. Covering RX as well as TX side
> for AF_INET6 to show case our 6LoWPAN implementation. For plain IEEE 802.15.4
> usage we demonstrate the AF_IEEE802154 socket and for some more specialized use
> cases AF_PACKET with and example of a constructed frame send from userspace.
>
> Stefan Schmidt (8):
>   examples: add README with details to the various examples
>   examples: af_ieee802154_tx example
>   examples: af_ieee802154_rx example
>   examples: add af_packet_rx example
>   examples: af_inet6_rx example
>   examples: af_packet_tx example
>   examples: af_inet6_tx example
>   examples: add .gitignore file for examples directory
>
>  Makefile.am                 |   3 +-
>  configure.ac                |   1 +
>  examples/.gitignore         |   7 +++
>  examples/Makefile.am        |   8 ++++
>  examples/README.examples    |  34 ++++++++++++++
>  examples/af_ieee802154_rx.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
>  examples/af_ieee802154_tx.c |  95 +++++++++++++++++++++++++++++++++++++
>  examples/af_inet6_rx.c      |  80 +++++++++++++++++++++++++++++++
>  examples/af_inet6_tx.c      |  75 ++++++++++++++++++++++++++++++
>  examples/af_packet_rx.c     |  95 +++++++++++++++++++++++++++++++++++++
>  examples/af_packet_tx.c     | 109 +++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 617 insertions(+), 1 deletion(-)
>  create mode 100644 examples/.gitignore
>  create mode 100644 examples/Makefile.am
>  create mode 100644 examples/README.examples
>  create mode 100644 examples/af_ieee802154_rx.c
>  create mode 100644 examples/af_ieee802154_tx.c
>  create mode 100644 examples/af_inet6_rx.c
>  create mode 100644 examples/af_inet6_tx.c
>  create mode 100644 examples/af_packet_rx.c
>  create mode 100644 examples/af_packet_tx.c

This series has been pushed to wpan-tools master.

regards
Stefan Schmidt
