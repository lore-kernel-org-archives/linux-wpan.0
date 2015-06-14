Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38073 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbFNXVQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 19:21:16 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] mac802154: rx packet handle cleanup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434093264-19451-1-git-send-email-varkab@cdac.in>
Date: Mon, 15 Jun 2015 01:21:10 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <A8E2C298-12B1-409B-9147-5E278C0DAE01@holtmann.org>
References: <1434093264-19451-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This patch replaces !netif_running(sdata->dev) with
> !ieee802154_sdata_running(sdata) and also devide the
> code two separate if branches.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> net/mac802154/rx.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

