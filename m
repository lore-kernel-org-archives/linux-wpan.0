Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38825 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966399AbaLLORZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:17:25 -0500
Message-ID: <548AF6D5.6030806@datenfreihafen.org>
Date: Fri, 12 Dec 2014 15:08:21 +0100
From: Stefan Schmidt <stefan@datenfreihafen.org>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-misc] website: inital commit
References: <1418392049-11101-1-git-send-email-alex.aring@gmail.com> <1418392049-11101-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418392049-11101-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 12/12/14 14:47, Alexander Aring wrote:
> +Rework
> +~~~~~~
> +
> +Currently a rework of 802.15.4 subsystem is in progress.
> +
> +The rework will contains a new netlink API and a general handling about frame creation and parsing.
> +
> +.Supported 802.15.4 Hardware

Better give this table a different name. :)

> +[options="header"]
> +|=======================================
> +|Milestone        | Description | state
> +|1. nl802154      | new netlink framework              | [green]#mostly done#
> +|2. crypto-layer  | accessable over nl802154 and tools | [red]#TODO#
> +|3. frame parsing | remove bugs, more generical        | [red]#TODO#
> +|=======================================
> +
> +For the nl802154 framework you will need the wpan-tools, older kernels need lowpan-tools but this is not recommended.
> +
> +// vim: set syntax=asciidoc:

regards
Stefan Schmidt
