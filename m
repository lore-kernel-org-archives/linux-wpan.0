Return-Path: <SRS0=/zsY=2P=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE92C2D0C8
	for <linux-wpan@archiver.kernel.org>; Wed, 25 Dec 2019 05:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB12620643
	for <linux-wpan@archiver.kernel.org>; Wed, 25 Dec 2019 05:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfLYFSk (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 25 Dec 2019 00:18:40 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:28998 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfLYFSk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Dec 2019 00:18:40 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 00:18:40 EST
IronPort-SDR: vtdtcTrtaj0jhqVh0sQWzGb44oSJbwOE8TY/jOlarqei4rHTrL3ta6JJ4FS2NO/BpK4PRdCal3
 XtaXDGOb7djA==
IronPort-PHdr: =?us-ascii?q?9a23=3ARaNawh9p29vx4f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B30uscTK2v8tzYMVDF4r011RmVBN6dsagfwLGM+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanf79+Mhu7oQrfu8UInIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRRn1gykFKjE56nnahMJwgqJBvhyvpAFxzIHIb4+aL/d+YqHQcs8GSW?=
 =?us-ascii?q?ZdQspdSSpMCZ68YYsVCOoBOP5VoY/nqFATtxW+HwisBObuyj9Uh3/2w7c12P?=
 =?us-ascii?q?kmHAHawQwgG84BsHXJo9rvL6cfSuW1w7PJzTXHdf9WxSny6IzWfRA5u/6DQa?=
 =?us-ascii?q?h8cdLNyUQ2EQ7Ok1aeqZT9Mj+Ly+gAsXKX4/duWO6zkWIrtQ58riKhy8osjI?=
 =?us-ascii?q?TCm5gbxUre9SpjxYY4Pdi4SElmbtG6CJZQrCSaN5duQsMlXmFopD42yr0Ytp?=
 =?us-ascii?q?6/eygH0JEnyATea/yDaYiH/BbjWPqeLDtimnJlf6+wiAy88UinzO3zSNO430?=
 =?us-ascii?q?hRriZdk9nMsG4C1wDL58SZV/dw/F2t1SuB2gzP8O1IP085mbDVJpMh2rIwk4?=
 =?us-ascii?q?AcsUXHHi/4gkX2i6qWe104+ui17+TofrTmqYKGOI9vkQz+N74hms27AegiLg?=
 =?us-ascii?q?gBQWyb9vqk1LL54UL1Wq1KjuEunqnDrJ/aPdgbprK+AwJN1oYj6hC/Dyqp0d?=
 =?us-ascii?q?gBk3gHNEhKeBScgoj3NFHBPur4Ae28g1uyijdrwe7JPrn7DpXKNHjDn+SpQb?=
 =?us-ascii?q?Eo709a1Rp20shW4bpKBbwbZvH+QEn8sJrfFBBqCQGsx/fbD4BZ38smQ2OKA7?=
 =?us-ascii?q?OYLqqa5VuB/vguJuiQZZEctS3VOf8l4PvnjHt/lEJLLoez2p5CTHnwJu5nJk?=
 =?us-ascii?q?SFYGTlyoMdDGMBvwY3V8TvgVyGFyJeY3uqVql6/i1tW9HuNpvKWo342O/J5y?=
 =?us-ascii?q?y8BJADPm0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EuEABy7wJelyMYgtllgkSDFjcbIBK?=
 =?us-ascii?q?TQlQGdR2KEoUzg3wVhhoMgVsNAQEBAQE1AgEBhECCIiQ4EwIDDQEBBQEBAQE?=
 =?us-ascii?q?BBQQBAQIQAQEBAQEIFgaFc0IBDAGBayKEF4EDgSyDA4JTKa1CGgKFI4RygTY?=
 =?us-ascii?q?BjBgaeYEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEac?=
 =?us-ascii?q?igjdVgQuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2EuEABy7wJelyMYgtllgkSDFjcbIBKTQlQGdR2KEoUzg?=
 =?us-ascii?q?3wVhhoMgVsNAQEBAQE1AgEBhECCIiQ4EwIDDQEBBQEBAQEBBQQBAQIQAQEBA?=
 =?us-ascii?q?QEIFgaFc0IBDAGBayKEF4EDgSyDA4JTKa1CGgKFI4RygTYBjBgaeYEHgUSCM?=
 =?us-ascii?q?oUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEacigjdVgQuBCnFNO?=
 =?us-ascii?q?IFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="317788561"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 25 Dec 2019 06:13:36 +0100
Received: (qmail 32416 invoked from network); 25 Dec 2019 04:33:53 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-wpan@vger.kernel.org>; 25 Dec 2019 04:33:53 -0000
Date:   Wed, 25 Dec 2019 05:33:43 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-wpan@vger.kernel.org
Message-ID: <19295920.259436.1577248424556.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

