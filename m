Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37096 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFWtV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Jun 2019 18:49:21 -0400
Received: by mail-lj1-f173.google.com with SMTP id 131so64642ljf.4
        for <linux-wpan@vger.kernel.org>; Thu, 06 Jun 2019 15:49:19 -0700 (PDT)
MIME-Version: 1.0
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Thu, 6 Jun 2019 19:49:07 -0300
Message-ID: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
Subject: Simulating 6lowpan with mac802154_hwsim
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello all,

I've been developed a wireless network emulator for IoT
(https://github.com/ramonfontes/mininet-iot) in which I'm using
mac802154_hwsim. Mininet-IoT extends Mininet-WiFi
(https://github.com/intrig-unicamp/mininet-wifi) by simulating WiFi
through mac80211_hwsim. Mininet-WiFi already supports 6lowpan with
fakelb and I moving everything to mac802154_hwsim. Since I'm using
iwpan with mac802154_hwsim and given the expertise of this community,
I was wondering whether there is any work in which simulate the data
rate based on the distance/rssi with 6lowpan. If the answer is no,
what would be the best way to do so? I was thinking of doing this with
TC, but TC wouldn't work well with multiple hops. Should I develop a
wmediumd-like simulator (https://github.com/bcopeland/wmediumd) for
mac802154_hwsim?

Best regards,
Ramon Fontes
