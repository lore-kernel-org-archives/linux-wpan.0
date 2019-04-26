Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f180.google.com ([209.85.166.180]:39413 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZE35 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Apr 2019 00:29:57 -0400
Received: by mail-it1-f180.google.com with SMTP id e13so3764522itk.4
        for <linux-wpan@vger.kernel.org>; Thu, 25 Apr 2019 21:29:57 -0700 (PDT)
Received: from ?IPv6:2601:245:c501:a88f:3496:7a24:52ca:e080? ([2601:245:c501:a88f:3496:7a24:52ca:e080])
        by smtp.gmail.com with ESMTPSA id p5sm5570935iom.51.2019.04.25.21.29.55
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 21:29:55 -0700 (PDT)
From: Aditya Nath <nath46950@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: wpan-ping not working for an initial setup of Openlabs 802.15.4
 modules connected to rapsberry pi.
Message-Id: <C17AA022-0F79-4663-877F-A4A0A62E141A@gmail.com>
Date: Fri, 26 Apr 2019 00:29:54 -0400
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

Sorry for creating another thread of mails, but I couldn=E2=80=99t =
figure out how to properly send the mail in the same chain using =
git-send-mail.

Anyways, I gathered some data after my last mail.

> What kernel version are you using on the rpi? Mainline or the =
Raspberry
> provided kernel?

The kernel on both the pi. It is the Raspberry provided kernel:
Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 =
armv7l GNU/Linux
There are tutorials giving directions to create a custom kernel in order =
to patch the driver support for at86rf233.
But for the Raspberry provided kernel, the device overlay was already =
present. So I did not go through the process
of creating the custom kernel.
> We had many problems that we helped debugging which ended in being a
> problem with the rpi kernel and SPI or the wrong wiring (or wrongly
> connected in the openlabs case). Thus I would like to ask you to =
double
> and triple check on these. :-)
I understand your concerns, but if there was a chance of device not =
connected properly (or the wiring issue) would it still show up in =
kernel messages as an identified device.
For example, the output of =E2=80=98dmesg | grep spi=E2=80=99:
[        3.990085] at86rf233 spi0.0: Detected at86rf233 chip version 2
> This would be the first time they would communicate? Or did you had =
this
> setup working before successfully?
This is the first time I=E2=80=99m trying to make the connection.
> Could you start wireshark/tshark/tcpdump on the server side wpan0
> interface and see if packets are actually arriving? If not, try the =
same
> on the client side wpan0 and check if you see them being submitted.
> Even better if you have another device (from which you know that it
> works) to use as a sniffer directly on the air.
=E2=80=94=E2=80=94=E2=80=94 Raspberry Pi3 - Acting as the IoT device =
with the OpenLabs module transmitting the data.

root@raspberrypi:/home/pi# ip link set wpan0 down
root@raspberrypi:/home/pi# iwpan phy0 set channel 0 15
root@raspberrypi:/home/pi# iwpan dev wpan0 set pan_id 0x1111
root@raspberrypi:/home/pi# iwpan dev wpan0 set short_addr 0x0002
root@raspberrypi:/home/pi# ip link set wpan0 up
root@raspberrypi:/home/pi# wpan-ping -a 0x0001  -s 5 -c5
PING 0x0001 (PAN ID 0x1111) 5 data bytes
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout

--- 0x0001 ping statistics ---
5 packets transmitted, 0 received, 100% packet loss
rtt min/avg/max =3D 2147483.750/0.000/0.000 ms
root@raspberrypi:/home/pi#=20


=E2=80=94=E2=80=94=E2=80=94 Raspberry Pi3 - Device having the monitor =
interface:

root@raspberrypi:/home/pi# tshark -i monitor0
Running as user "root" and group "root". This could be dangerous.
Capturing on 'monitor0'
    1 0.000000000              =E2=86=92              IEEE 802.15.4 143 =
Beacon, Bad FCS
    2 0.002232663              =E2=86=92              IEEE 802.15.4 143 =
Beacon, Bad FCS
    3 0.005587516              =E2=86=92              IEEE 802.15.4 143 =
Beacon, Bad FCS
    4 0.008298513              =E2=86=92              IEEE 802.15.4 143 =
Beacon, Bad FCS
    5 0.499330889              =E2=86=92              IEEE 802.15.4 143 =
Beacon, Bad FCS

> Another thing you could try is to setup 6lowpan fully and see if ping6
> works. That would rule out problems with wpan-ping.
Setting up LowPan to see if ping over ipv6 works:

=E2=80=94=E2=80=94=E2=80=94 Raspberry pi - Node 1

root@raspberrypi:/home/pi# ip link set lowpan0 down
Cannot find device "lowpan0"
root@raspberrypi:/home/pi# ip link set wpan0 down
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# iwpan dev wpan0 set pan_id 0xcafe
root@raspberrypi:/home/pi# iwpan phy0 set channel 0 26
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# ip link add link wpan0 name lowpan0 type =
lowpan
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# ip link set wpan0 up
root@raspberrypi:/home/pi# ip link set lowpan0 up
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# ip addr add 2001:db8::1/64 dev lowpan0=20
root@raspberrypi:/home/pi#=20

=E2=80=94=E2=80=94=E2=80=94 Raspberry Pi - Node 2

root@raspberrypi:/home/pi# ip link set lowpan0 down
Cannot find device "lowpan0"
root@raspberrypi:/home/pi# ip link set wpan0 down
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# iwpan dev wpan0 set pan_id 0xcafe
root@raspberrypi:/home/pi# iwpan phy0 set channel 0 26
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# ip link add link wpan0 name lowpan0 type =
lowpan
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# ip link set wpan0 up
root@raspberrypi:/home/pi# ip link set lowpan0 up
root@raspberrypi:/home/pi#=20
root@raspberrypi:/home/pi# ip addr add 2001:db8::2/64 dev lowpan0
root@raspberrypi:/home/pi# ping6 2001:db8::1
PING 2001:db8::1(2001:db8::1) 56 data bytes
=46rom 2001:db8::2 icmp_seq=3D1 Destination unreachable: Address =
unreachable
=46rom 2001:db8::2 icmp_seq=3D2 Destination unreachable: Address =
unreachable
=46rom 2001:db8::2 icmp_seq=3D3 Destination unreachable: Address =
unreachable
^C
--- 2001:db8::1 ping statistics ---
5 packets transmitted, 0 received, +3 errors, 100% packet loss, time =
4200ms


Hopefully, I=E2=80=99ve provided all the information required for the =
help that I=E2=80=99m asking.=20

Thank you for your time again,
Aditya Nath=
